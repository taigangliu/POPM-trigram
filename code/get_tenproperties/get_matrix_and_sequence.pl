require "../predefine.pl";

$ClassNo=$ARGV[0]; 

open(IN,"../tenproperties.csv")||die;
@in=<IN>;
chomp @in;
close(IN);

@ABC=("A","C","D","E","F","G","H","I","K","L","M","N","P","Q","R","S","T","V","W","Y"); 

%hash=();
for($i=0;$i<20;$i++)
{
	@temp=split(/,/,$in[$i]); 
	$hash{$ABC[$i]}=join(" ",@temp);
}

foreach $key (keys %hash)
{
	print $key," ", $hash{$key},"\n";
}

$dir0="../../result/$SubLoc[$ClassNo]/tenproperties_matrix_and_sequence";
if(opendir(DIR0,$dir0))
{
	closedir(DIR0);
}
else
{
	mkdir ($dir0,0755)||die;
}

$infile="../../dataset/$SubLoc[$ClassNo]";
open(IN,$infile)||die;
@in=<IN>;
chomp @in;
close(IN);
$SeqNum=@in/2;  

for($i=0;$i<$SeqNum;$i++)
{
	open(OUT,">$dir0/$i")||die;
	
	$infile="../../result/$SubLoc[$ClassNo]/sequence/$i";
	open(IN,$infile)||die;
	@in=<IN>;
	close(IN);
	for($j=0;$j<@in;$j++)
	{
		$in[$j]=~s/\r//;
		$in[$j]=~s/\n//;
	}
	@temp=split(//,$in[1]);
	$sum=0;
	$error=0;
	for($j=0;$j<@temp;$j++)
	{
		$temp[$j]=uc($temp[$j]);  
		if(length($hash{$temp[$j]}) < 2)  
		{
			$error++;
			next;
		}
		$sum++;
		print OUT scalar($sum)," ",$temp[$j]," ",$hash{$temp[$j]},"\n";
	}
	close(OUT);
	if($error == 0)
	{
		print "The $i sequence is ok!\n"; 
	}
	else
	{
		print "The $i sequence is ok! The number of unusual character is : $error\n";
	}
	
}

print "The program is over!\n";