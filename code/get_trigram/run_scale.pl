$NameNo=0; 
@DataName=("ZW225");

$datadir="/data/tgliu/program/SubLoc/$DataName[$NameNo]/result/merged_FeatureVector/tenproperties-trigram";

system "/data/tgliu/program/libsvm/svm-scale -l 0 $datadir/FV > $datadir/FV-libsvmscale";

print "The program is over!\n";