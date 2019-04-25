require "../predefine.pl";

$ClassNo=$ARGV[0]; 

$infile="../../dataset/$SubLoc[$ClassNo]";
open(IN,$infile)||die;
@in=<IN>;
chomp @in;
close(IN);

$dir0="../../result";
if(opendir(DIR0,$dir0))
{
	closedir(DIR0);
}
else
{
	mkdir ($dir0,0755)||die;
}
$dir1="$dir0/$SubLoc[$ClassNo]";
if(opendir(DIR1,$dir1))
{
	closedir(DIR1);
}
else
{
	mkdir ($dir1,0755)||die;
}
$dir2="$dir1/sequence";
if(opendir(DIR2,$dir2))
{
	closedir(DIR2);
}
else
{
	mkdir ($dir2,0755)||die;
}

$num=0;
for($i=0;$i<@in;$i+=2)
{	
	open(OUT,">$dir2/$num")||die;	
	print OUT $in[$i],"\n";
	print OUT $in[$i+1],"\n";
	close(OUT);
	$num++;
}
print "The number of sequences is $num\n";

print "The program is over!\n";