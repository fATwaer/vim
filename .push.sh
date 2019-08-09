mkdir -p ~/vimbash
cp .bash* ~/vimbash > /dev/null 2>&1


## truncate work part

line=`grep -n '## ->truncate<- ##' ~/.bashrc | awk -F ':' '{print $1}'`
head -n $line ~/.bashrc > ~/vimbash/.bashrc

