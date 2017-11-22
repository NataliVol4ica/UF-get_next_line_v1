./$1 > $2/E_ans
diff $2/E_cor $2/E_ans > temp
num=`wc -l < temp`
rm temp
#echo "./$1 $2_inp > $2_ans"
if [ "$num" -eq "0" ]
then
	echo '\033[0;32m'"OK :)"'\033[0m'
else
	echo "KO :( \n Files are having difference."
fi