for f in `find . -name '*replaceme.jpg'` ; do mv $f ${f/replaceme/withme}; done
