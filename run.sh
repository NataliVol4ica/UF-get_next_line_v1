./test_gnl $1_inp > $1_ans
diff $1_cor $1_ans > temp
num=`wc -l < temp`
rm temp
if [ "$num" -eq "0" ]
then
	echo '\033[0;32m'"OK :)"'\033[0m'
else
	echo "KO :( \n Files are having difference."
fi