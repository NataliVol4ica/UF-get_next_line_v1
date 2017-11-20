./test_gnl $1 > $1_t
if diff $1 $1_t | wc -l
then
	echo "KO :( \n Files are having difference."
else
	echo "OK :)"
fi