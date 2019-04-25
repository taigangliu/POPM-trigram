In order to use the source code, you will need to have Perl, R, BLAST and LIBSVM installed.

This directory includes two subdirectories: 1) code; 2) dataset. The former includes all source codes. The latter includes four sample datasets. 

The "code" directory has three subdirectores (named get_tenproperties, get_trigram, svm_rfe), a file named "tenproperties.csv", and a file named "predefine.pl" which is a configuration file.

In the "get_tenproperties" directory, all source codes are performed in order. (splice_seq.pl --> get_matrix_and_sequence.pl --> get_matrix_transposed.pl)

In the "get_trigram" directory, all source codes are performed in order. (get_feature.pl --> to_libsvm_format.pl --> merge_libsvm_format.pl --> run_scale.pl)

In the "svm_rfe" directory, all source codes are performed in order. (libsvm2rfe-scale.pl --> onlyfeatureselect-scale.r --> resortFV.r --> tolibsvmtopK.pl --> runlinearSVM.r)
 
For any questions and comments, please email tgliu@shou.edu.cn .