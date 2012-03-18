#!/usr/bin/perl

# File uploading script
#
# $Id: upl_once.pl,v 1.2 2009/04/14 12:39:10 oraz Exp $

use CGI;
use LWP::UserAgent;
use HTTP::Headers;
use HTTP::Response;
use HTTP::Request;

use POSIX qw(strftime setlocale);
use integer;
use FindBin;
use strict;

use lib $FindBin::Bin . '/../pm';
use ban_edit;

my $sess_time = 600;

my $g_time_upload = time();

# --- global variables
my @CFGDIRS=($FindBin::Bin . '/../conf'); # path with config-files

push(@INC, @CFGDIRS);

use ban_edit;

# read configuration
my %Config=();      # configuration hash
my $cfg = read_config(\@CFGDIRS);
if(!$cfg)
{
    warn "ban_upload: can't read configuration";
    exit(1);
}
%Config = %$cfg;

my @aref = split(/\s+/, $Config{UPL_URLS});
$Config{UPL_URL_ARR} = \@aref;

my $cgi = new CGI;
my $user = $cgi->param('user');
my $field = $cgi->param('field');
my $sid = $cgi->param('sid');

my ($message, $fatal_error, $uploaded_file);

# check
$fatal_error = check_user() || check_sid();

if($cgi->request_method() && $cgi->request_method() eq 'POST')
{
    $uploaded_file = upload_file();
    $message = $! if(!$uploaded_file);
    #$uploaded_file = "$Config{UPL_USER_URL}/$user/".$cgi->param('file') if(!$error);
}
if(!$message)
{
    $message = "";
    $message = "Файл загружен: <input readonly style=\"background-color: white; border: 1px; width: 400px; \" type=\"text\" value=\"$uploaded_file\">" if($uploaded_file);
}

my $js_field = $field || "unexistent_field";
my $html_fail = "<tr><td>".($fatal_error || "")."</td></tr>";
my $html_ok =<<HTML_OK;
<tr><td>Файл:</td><td>&nbsp;</td></tr><tr><td colspan="2"><input type="file" name="upfile" id="upfile" style="width: 400px; height: 24px;">&nbsp;&nbsp;<input type="submit" value="Загрузить" style="height: 24px;"></td></tr>
<tr><td align="left"><br>$message</td><td align="right">&nbsp;</td></tr>
HTML_OK
my $jscript = "";
if($uploaded_file)
{
    $jscript =<<JSCRIPT;
<script>
<!--
document.domain = "rambler.ru";

try
{
for(i = 0; i < window.opener.document.forms.length; i++)
{
    if(window.opener.document.forms[i].id == 'params')
    {
        window.opener.document.forms[i].$js_field.value = "$uploaded_file";
    }
}
self.close();
}
catch(err)
{}
-->
</script>
JSCRIPT

}

my $content = $fatal_error ? $html_fail : $html_ok;
my $url = $cgi->url();
my $success = "";
if(!$fatal_error && $uploaded_file)
{
    $success =<<HTML_SUCCESS;
<table cellspacing="3" align="left" border="0">
<tr><td>
<script type="text/javascript">
<!--
    document.write("File uploaded: $uploaded_file");
-->
</script>
</td></tr>
</table>
HTML_SUCCESS
}
my $html_out =<<HTML_OUT;
<html><head>
<title>Быстрая загрузка файла</title>
</head>
$jscript
<body>
<form action="$url" method="post" enctype="multipart/form-data">
<input type="hidden" name="user" value="$user">
<input type="hidden" name="field" value="$field">
<input type="hidden" name="sid" value="$sid">
<table cellspacing="3" border="0" align="center">$content
</table>
</form>
</body></html>

HTML_OUT

print "Content-type: text/html\n\n";
print $html_out;

sub upload_file {
    my ($fh, $fname, $uploaded);
    if($fname = $cgi->param('upfile'))
    {
        ($fname) = ($fname =~ m/([\w-]+.?\w*)$/);
        $fh = $cgi->param('upfile');
    }

    $fname = make_uniq_fname($user, $fname);
    #warn "result: $fname";
    if($fname && length($fname))
    {
        my $file = $fname;

        binmode($fh);
        my($bytesread, $buffer, $bytes, $byteslen);
        while($bytesread = read($fh, $buffer, 4096))
        {
            $bytes .= $buffer;
            $byteslen += $bytesread;
        }

        my $is_uploaded = 0;

        foreach my $url (@{$Config{UPL_URL_ARR}})
        {
            my $ret = upl_put($bytes, $byteslen, $url . '/'. $user. '/' . $fname);
            if(!$ret)
            {
                $is_uploaded++;
                $uploaded = join('/', ($Config{UPL_USER_URL}, $user, $fname));
                print_errlog("'$user/$fname' uploaded remote on $url") if($Config{UPL_VERBOSE});
            }
            else
            {
                print_errlog("can't upload '$user/$fname' remote to $url: $ret");
            }
        }

        if($Config{UPL_LOCAL_DIR})
        {
            my $full_file = join('/', ($Config{UPL_LOCAL_DIR}, $user, $fname));

            my $dir = "$Config{UPL_LOCAL_DIR}/$user";

            my $is_uploaded_local = 0;
            {
                if(!-e $dir && !mkdir($dir, 0777))
                {
                    last;
                }

                open(F, "> $full_file") or last;
                binmode(F);
                print F $bytes;
                close(F);
                system('touch -am -t '.strftime("%Y%m%d%H%M.%S", localtime($g_time_upload)) . " $full_file");

                if(!$uploaded)
                {
                    $uploaded = join('/', ($Config{UPL_LOCAL_URL}, $user, $fname));
                }
                $is_uploaded_local++;
            }
            $is_uploaded += $is_uploaded_local;

            if(!$is_uploaded_local)
            {
                print_errlog("can't upload local to $full_file ($!)");
            }
            else
            {
                print_errlog("'$user/$fname' uploaded local $Config{UPL_LOCAL_DIR}") if($Config{UPL_VERBOSE});
            }
        }

        if($is_uploaded == 0)
        {
            $! = "internal error";
            return undef;
        }

        $cgi->param('file', $file);
    }
    else
    {
        $! = "file not specified";
        return undef;
    }

    return $uploaded;
}

sub upl_put {
    my ($bytes, $len, $url) = @_;

    my $locale = setlocale("LC_TIME", "en_US.US-ASCII");
    my $header = HTTP::Headers->new('Content-Length' => $len,
                                    'Date' => strftime("%a, %d %b %Y %T GMT\n", gmtime($g_time_upload))
                 );
    setlocale("LC_TIME", $locale);

    my $ua = LWP::UserAgent->new();
    $ua->default_headers($header);

    my $req = HTTP::Request->new('PUT', $url, $header, $bytes);
    $req->protocol('HTTP/1.1');

    my $resp = $ua->request($req);
    if($resp->is_error())
    {
        #print STDERR 'upl_once: '. $resp->status_line()."\n";
        return $resp->status_line();
    }

    return 0;
}

sub make_uniq_fname {
    my ($user, $fname) = @_;

    my ($url, @urls, $req, $resp);
    my $ua = LWP::UserAgent->new();

    my ($i, $found) = (0, 0);
    my $fname_orid = $fname;
    while(1)
    {
        $found = 0;
        @urls = ();
        if($Config{UPL_USER_URL})
        {
            push(@urls, join("/", ($Config{UPL_USER_URL}, $user, $fname)));
        }
        if($Config{UPL_LOCAL_URL})
        {
            push(@urls, join("/", ($Config{UPL_LOCAL_URL}, $user, $fname)));
        }

        foreach $url (@urls)
        {
            #warn "make_uniq_fname: $url";
            $req = HTTP::Request->new('GET', $url);
            $req->protocol('HTTP/1.1');

            $resp = $ua->request($req);
            if(!$resp->is_error())
            {
                $found = 1;
                last;
            }
        }
        #warn "make_uniq_fname: $fname ". ($found ? "found" : "not found");

        return $fname if(!$found);

        $fname = gen_rand_fname($fname_orid, 3+$i);
        last if(++$i == 10);
    }
    return $fname;
}

sub gen_rand_fname {
    my $fname = shift;
    my $suf_length = shift || 3;
    srand;

    my ($name, $ext) = ($fname =~ m/^([\w-]+)\.?(\w*)$/);

    $name .= "_";
    for (0..$suf_length-1)
    {
        my $val = rand(36);
        $val = $val < 26 ? chr(ord('a') + $val) : chr(ord('0') + $val-26);
        $name .= $val;
    }

    $name .= ".$ext" if($ext);

    return $name;
}


sub check_sid {
    my ($time, $code) = ($cgi->param('sid') =~ m/^(\d+)[\+|\s](\d+)$/);

    my $res = gen_sid($time, $cgi->param('user'));

    if((time() >= $time+$sess_time) || ($res != $code))
    {
        warn "upl_once: bad code ($res, $code)";
        sleep 2;
        return "нет доступа";
    }

    return undef;
}

sub check_user {
    if($user)
    {
        $user =~ s/^\s+//;
        $user =~ s/\s+$//;
    }
    if(!$user || !length($user) || ($user !~ m/^[\w-]+$/))
    {
        sleep 2;
        return "нет доступа";
    }

    return undef;
}

sub print_errlog {
     my $s = shift;
     return if(!defined($s));

     print STDERR join(' ', ("upl_once:", strftime("%d/%b/%Y:%T %z", localtime()), $s))."\n";
}
