#/usr/bin/env bash
set -euo pipefail

echo "preparing METABOLIC files..."
tar zxvf Accessory_scripts.tgz; rm Accessory_scripts.tgz
tar zxvf METABOLIC_hmm_db.tgz;  rm METABOLIC_hmm_db.tgz
tar zxvf METABOLIC_template_and_database.tgz; rm  METABOLIC_template_and_database.tgz
tar zxvf Motif.tgz; rm Motif.tgz

echo "preparing kofam files..."
mkdir kofam_database
cd kofam_database
curl -O ftp://ftp.genome.jp/pub/db/kofam/ko_list.gz
curl -O ftp://ftp.genome.jp/pub/db/kofam/profiles.tar.gz
gzip -d ko_list.gz
tar xzf profiles.tar.gz; rm profiles.tar.gz
mv ../All_Module_KO_ids.txt profiles
cd profiles  
cp ../../Accessory_scripts/batch_hmmpress.pl ./
perl batch_hmmpress.pl
cd ../
cd ../

echo "preparing dbCAN2 files..."
mkdir dbCAN2
cd dbCAN2
wget https://bcb.unl.edu/dbCAN2/download/Databases/dbCAN-old@UGA/dbCAN-fam-HMMs.txt.v10 -O dbCAN-fam-HMMs.txt
perl ../Accessory_scripts/batch_hmmpress_for_dbCAN2_HMMdb.pl
cd ../

echo "preparing MEROPS files..."
mkdir MEROPS
cd MEROPS
wget https://ftp.ebi.ac.uk/pub/databases/merops/current_release/pepunit.lib
perl ../Accessory_scripts/make_pepunit_db.pl
cd ../

echo "preparing METABOLIC test files..."
wget -c https://figshare.com/ndownloader/files/43500597 -O METABOLIC_test_files.tgz
tar zxvf METABOLIC_test_files.tgz
rm *.tgz
