
$NameNo=0;

$method="tenproperties-trigram";

$fvname="sortedFV-libsvmscale";

@DataName=("ZW225");

print "tolibsvmtopK $DataName[$NameNo] is running...\n";

$datadir="/data/tgliu/program/SubLoc/$DataName[$NameNo]";

$dir0="$datadir/result/svm-rfe/$method/grid_result_libsvmscale";
if(opendir(DIR0,$dir0))
{
	closedir(DIR0);
}
else
{
	mkdir ($dir0,0755)||die;
}

open(IN,"$datadir/result/svm-rfe/$method/$fvname")||die;
@in=<IN>;
chomp @in;
close(IN);

for($i=10;$i<=500;$i+=10)
{
	open(OUT,">$dir0/libsvmFVtop-$i")||die;
	for($j=0;$j<@in;$j++)
	{
		@temp=split(/ +/,$in[$j]);
		print OUT $temp[0]," ";
		for($k=1;$k<=$i;$k++)
		{
			print OUT "$k:$temp[$k] ";
		}
		print OUT "\n";
	}
	close(OUT);
	print "Top $i is ok!\n";
}

print "The program is over!\n";