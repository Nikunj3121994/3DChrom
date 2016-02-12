###############################################################################################
#                                                                                          
# Description: This file combines smaller files into larger files.
# Language: Perl
# Author: Jacob R. Porter
# Date: 10/16/2015
#
###############################################################################################

###############################################################################################
#
# The first thing that we want to do is turn our hgdf_x_base_sorted.txt into a flat file.     
# It contains the following indexes:                                                          
# [0]EnsemblGeneID, [1]EnsemblTranscriptID, [2]EnsemblProteinID, [3]Description, [4]GeneStart
# [5]GeneEnd, [6]TranscriptStart, [7]TranscriptEnd                                            
#
###############################################################################################

open(MYINPUTFILE, "<hgdf_x_base_sorted.txt");
open(my $outputFile, '>', 'hgdf_x_base_flat.txt');

my @hgdf_x_base_array;
my @hgdf_x_external_1_array;
my @hgdf_x_external_2_array;
my @hgdf_x_protein_array;

my $previousGene = 123123;
my $i = 0;
my $j = 0;
          
while(<MYINPUTFILE>) {
	chomp;
        my $line = $_;
	$line =~ s/'//;
	$line =~ s/\n//;
	$line =~ s/"//;

        my @hgdfarray = split/\t/, $line;

	if ($hgdfarray[0] eq $previousGene) {
		# Associated with genes may be multiple transcript_id, protein_id, and the transcript_start and transcript_end will change. Therefore, we are storing all those possible
		# values in elements with format 1*2*3

		$hgdf_x_base_array[$j-1][1] = $hgdf_x_base_array[$j-1][1] . "*" . $hgdfarray[1];
		$hgdf_x_base_array[$j-1][2] = $hgdf_x_base_array[$j-1][2] . "*" . $hgdfarray[2];
		$hgdf_x_base_array[$j-1][6] = $hgdf_x_base_array[$j-1][6] . "*" . $hgdfarray[6];
		$hgdf_x_base_array[$j-1][7] = $hgdf_x_base_array[$j-1][7] . "*" . $hgdfarray[7];

	} else {
		$hgdf_x_base_array[$j][0] = $hgdfarray[0];
        	$hgdf_x_base_array[$j][1] = $hgdfarray[1];
        	$hgdf_x_base_array[$j][2] = $hgdfarray[2];
        	$hgdf_x_base_array[$j][3] = $hgdfarray[3];
        	$hgdf_x_base_array[$j][4] = $hgdfarray[4];
        	$hgdf_x_base_array[$j][5] = $hgdfarray[5];
        	$hgdf_x_base_array[$j][6] = $hgdfarray[6];
        	$hgdf_x_base_array[$j][7] = $hgdfarray[7];

		$j = $j+1;
		$previousGene = $hgdfarray[0];
	}
    
}

close MYINPUTFILE;

#print $hgdf_x_base_array[1][7];

foreach (@hgdf_x_base_array) {
	print $outputFile @$_[0] . "\t" . @$_[1] . "\t" . @$_[2] . "\t" . @$_[3] . "\t" . @$_[4] . "\t" . @$_[5] . "\t" . @$_[6] . "\t" . @$_[7]."\n";
}

close $outputFile;
print "Done with hgdf_x_base_array!"."\n";

####################################################################################################################
#
# Second, we create a flat array from our hgdf_x_external_1_sorted.txt file                                 
# It contains the following indexes:
# [0]EnsemblGeneID, [1]GoTermAccession,[2]GoTermName, [3]GoTermDefinition,
# [4]GoTermEvidenceCode, [5]GoDomain, [6]PdbID, [7]UniprotTremblAccession, [8]UniprotSwissprotAccession
#   
####################################################################################################################

open(MYINPUTFILE, "<hgdf_x_external_1_sorted.txt");
open(my $outputFile, '>', 'hgdf_x_external_1_flat.txt');

$i = 0;
$j = 0;
$previousGene = 123123123;

while(<MYINPUTFILE>) {
        chomp;
        my $line = $_;
        $line =~ s/'//;
	$line =~ s/\n//;
        $line =~ s/"//;

        my @hgdfarray = split/\t/, $line;

	if ($hgdfarray[0] eq $previousGene) {
                # Associated with genes may be multiple transcript_id, protein_id, and the transcript_start and transcript_end will change. Therefore, we are storing all those possible
                # values in elements with format 1*2*3

                $hgdf_x_external_1_array[$j-1][1] = $hgdf_x_external_1_array[$j-1][1] . "*" . $hgdfarray[1];
                $hgdf_x_external_1_array[$j-1][2] = $hgdf_x_external_1_array[$j-1][2] . "*" . $hgdfarray[2];
                $hgdf_x_external_1_array[$j-1][3] = $hgdf_x_external_1_array[$j-1][3] . "*" . $hgdfarray[3];
                $hgdf_x_external_1_array[$j-1][4] = $hgdf_x_external_1_array[$j-1][4] . "*" . $hgdfarray[4];
		$hgdf_x_external_1_array[$j-1][5] = $hgdf_x_external_1_array[$j-1][5] . "*" . $hgdfarray[5];
		$hgdf_x_external_1_array[$j-1][6] = $hgdf_x_external_1_array[$j-1][6] . "*" . $hgdfarray[6];
		$hgdf_x_external_1_array[$j-1][7] = $hgdf_x_external_1_array[$j-1][7] . "*" . $hgdfarray[7];
		$hgdf_x_external_1_array[$j-1][8] = $hgdf_x_external_1_array[$j-1][8] . "*" . $hgdfarray[8];

        } else {
                $hgdf_x_external_1_array[$j][0] = $hgdfarray[0];
                $hgdf_x_external_1_array[$j][1] = $hgdfarray[1];
                $hgdf_x_external_1_array[$j][2] = $hgdfarray[2];
                $hgdf_x_external_1_array[$j][3] = $hgdfarray[3];
                $hgdf_x_external_1_array[$j][4] = $hgdfarray[4];
                $hgdf_x_external_1_array[$j][5] = $hgdfarray[5];
                $hgdf_x_external_1_array[$j][6] = $hgdfarray[6];
                $hgdf_x_external_1_array[$j][7] = $hgdfarray[7];
		$hgdf_x_external_1_array[$j][8] = $hgdfarray[8];

                $j = $j+1;
                $previousGene = $hgdfarray[0];
        }
}

close MYINPUTFILE;

foreach (@hgdf_x_external_1_array) {
        print $outputFile @$_[0] . "\t" . @$_[1] . "\t" . @$_[2] . "\t" . @$_[3] . "\t" . @$_[4] . "\t" . @$_[5] . "\t" . @$_[6] . "\t" . @$_[7]. "\t" . @$_[8]."\n";
}

close $outputFile;

print "Done with hgdf_x_external_array_1!"."\n";

####################################################################################################################
#
# Third, we create a flat array from our hgdf_x_external_2_sorted.txt file
# It contains the following indexes:
# [0]EnsemblGeneID, [1]UniprotGeneName, [2]UniprotTranscriptName
#
####################################################################################################################

open(MYINPUTFILE, "<hgdf_x_external_2_sorted.txt");
open(my $outputFile, '>', 'hgdf_x_external_2_flat.txt');


$i = 0;
$j = 0;
$previousGene = 123123123;

while(<MYINPUTFILE>) {
        chomp;
        my $line = $_;
        $line =~ s/'//;
        $line =~ s/"//;
	$line =~ s/\n//;


        my @hgdfarray = split/\t/, $line;

	# There seems to only be one UniprotGeneName and UniprotTranscriptName with each EnsemblGeneID, so only the else is necessary.
        if ($hgdfarray[0] eq $previousGene) {

        } else {
                $hgdf_x_external_2_array[$j][0] = $hgdfarray[0];
                $hgdf_x_external_2_array[$j][1] = $hgdfarray[1];
                $hgdf_x_external_2_array[$j][2] = $hgdfarray[2];

                $j = $j+1;
                $previousGene = $hgdfarray[0];
        }
}

close MYINPUTFILE;

foreach (@hgdf_x_external_2_array) {
        print $outputFile @$_[0] . "\t" . @$_[1] . "\t" . @$_[2]."\n";
}

close $outputFile;


print "Done with hgdf_x_external_array_2!"."\n";

####################################################################################################################
#
# Fourth, we create a flat array from our hgdf_x_protein_sorted.txt file
# It contains the following indexes:
# [0]EnsemblGeneID, [1]PfamID, [2]PfamStart, [3]PfamEnd, [4]EnsemblProteinFamilyID, [5]EnsemblFamilyDescription
# [6]InterproID, [7]InterproShortDescription, [8]InterproDescription, [9]PfscanID, [10]PfscanStart, [11]PfscanEnd
# [12]InterproStart, [13]InterproEnd
#
####################################################################################################################

open(MYINPUTFILE, "<hgdf_x_protein_sorted.txt");
open(my $outputFile, '>', 'hgdf_x_protein_flat.txt');

$i = 0;
$j = 0;
$previousGene = 123123123;

while(<MYINPUTFILE>) {
        chomp;
        my $line = $_;
        $line =~ s/'//;
        $line =~ s/"//;
	$line =~ s/\n//;


        my @hgdfarray = split/\t/, $line;

        if ($hgdfarray[0] eq $previousGene) {
                # Associated with genes may be multiple transcript_id, protein_id, and the transcript_start and transcript_end will change. Therefore, we are storing all those possible
                # values in elements with format 1*2*3

                $hgdf_x_protein_array[$j-1][1] = $hgdf_x_protein_array[$j-1][1] . "*" . $hgdfarray[1];
                $hgdf_x_protein_array[$j-1][2] = $hgdf_x_protein_array[$j-1][2] . "*" . $hgdfarray[2];
                $hgdf_x_protein_array[$j-1][3] = $hgdf_x_protein_array[$j-1][3] . "*" . $hgdfarray[3];
                $hgdf_x_protein_array[$j-1][4] = $hgdf_x_protein_array[$j-1][4] . "*" . $hgdfarray[4];
                $hgdf_x_protein_array[$j-1][5] = $hgdf_x_protein_array[$j-1][5] . "*" . $hgdfarray[5];
                $hgdf_x_protein_array[$j-1][6] = $hgdf_x_protein_array[$j-1][6] . "*" . $hgdfarray[6];
                $hgdf_x_protein_array[$j-1][7] = $hgdf_x_protein_array[$j-1][7] . "*" . $hgdfarray[7];
                $hgdf_x_protein_array[$j-1][8] = $hgdf_x_protein_array[$j-1][8] . "*" . $hgdfarray[8];
		$hgdf_x_protein_array[$j-1][9] = $hgdf_x_protein_array[$j-1][9] . "*" . $hgdfarray[9];
		$hgdf_x_protein_array[$j-1][10] = $hgdf_x_protein_array[$j-1][10] . "*" . $hgdfarray[10];
		$hgdf_x_protein_array[$j-1][11] = $hgdf_x_protein_array[$j-1][11] . "*" . $hgdfarray[11];
		$hgdf_x_protein_array[$j-1][12] = $hgdf_x_protein_array[$j-1][12] . "*" . $hgdfarray[12];
		$hgdf_x_protein_array[$j-1][13] = $hgdf_x_protein_array[$j-1][13] . "*" . $hgdfarray[13];

        } else {
		print "$hgdfarray[0]"."\n";

                $hgdf_x_protein_array[$j][0] = $hgdfarray[0];
                $hgdf_x_protein_array[$j][1] = $hgdfarray[1];
                $hgdf_x_protein_array[$j][2] = $hgdfarray[2];
                $hgdf_x_protein_array[$j][3] = $hgdfarray[3];
                $hgdf_x_protein_array[$j][4] = $hgdfarray[4];
                $hgdf_x_protein_array[$j][5] = $hgdfarray[5];
                $hgdf_x_protein_array[$j][6] = $hgdfarray[6];
                $hgdf_x_protein_array[$j][7] = $hgdfarray[7];
                $hgdf_x_protein_array[$j][8] = $hgdfarray[8];
		$hgdf_x_protein_array[$j][9] = $hgdfarray[9];
		$hgdf_x_protein_array[$j][10] = $hgdfarray[10];
		$hgdf_x_protein_array[$j][11] = $hgdfarray[11];
		$hgdf_x_protein_array[$j][12] = $hgdfarray[12];
		$hgdf_x_protein_array[$j][13] = $hgdfarray[13];

                $j = $j+1;
                $previousGene = $hgdfarray[0];
        }
}

close MYINPUTFILE;

foreach (@hgdf_x_external_1_array) {
        print $outputFile @$_[0] . "\t" . @$_[1] . "\t" . @$_[2] . "\t" . @$_[3] . "\t" . @$_[4] . "\t" . @$_[5] . "\t" . @$_[6] . "\t" . @$_[7]. "\t" . @$_[8] . "\t" . @$_[9] . "\t" . @$_[10] . "\t" . @$_[11] . "\t" . @$_[12] . "\t" . @$_[13]."\n";
}

close $outputFile;


print "Done with hgdf_x_protein_array!"."\n";

###############################################################################################################
# We now have four arrays:
# my @hgdf_x_base_array;
# my @hgdf_x_external_1_array;
# my @hgdf_x_external_2_array;
# my @hgdf_x_protein_array;
#
# We will combine the latter 3 arrays into @hgdf_x_base_array by pushing the indexes after [0] if [0] has the
# same EnsmemblGeneID as $hgdf_x_base_array[0]
#
##############################################################################################################
$i = 0;
foreach (@hgdf_x_base_array) {
#       print $outputFile @$_[0] . "\t" . @$_[1] . "\t" . @$_[2] . "\t" . @$_[3] . "\t" . @$_[4] . "\t" . @$_[5] . "\t" . @$_[6] . "\t" . @$_[7]."\n";

	print "Array entered."."\n";
	
	foreach $external_1(@hgdf_x_external_1_array) {
		print "For Each Entered."."\n";
		if (@$external_1[0] eq @$_[0]) {
			$hgdf_x_base_array[$i][8] = @$external_1[1];
			$hgdf_x_base_array[$i][9] = @$external_1[2];
			$hgdf_x_base_array[$i][10] = @$external_1[3];
			$hgdf_x_base_array[$i][11] = @$external_1[4];
			$hgdf_x_base_array[$i][12] = @$external_1[5];
			$hgdf_x_base_array[$i][13] = @$external_1[6];
			$hgdf_x_base_array[$i][14] = @$external_1[7];
			$hgdf_x_base_array[$i][15] = @$external_1[8];
			print $hgdf_x_base_array[$i][15]."\n";
		}	
	}
	$i = $i+1;

}

foreach (@hgdf_x_base_array) {
	print $outputFile @$_[0] . "\t" . @$_[1] . "\t" . @$_[2] . "\t" . @$_[3] . "\t" . @$_[4] . "\t" . @$_[5] . "\t" . @$_[6] . "\t" . @$_[7] . "\t" . @$_[8] . "\t" . @$_[9] . "\t" . @$_[10] . "\t" . @$_[11] . "\t" . @$_[12] . "\t" . @$_[13] . "\t" . @$_[14] . "\t" . @$_[15] . "\n";

}
close $outputfile;
print "Done";
