-- Load input file from HDFS
inputFile = LOAD 'hdfs:///user/ruchika/input.txt' AS (line:chararray);
-- Tokeize each word in the file (Map)
words = FOREACH inputFile GENERATE FLATTEN(TOKENIZE(line)) AS word;
-- Combine the words from the above stage
grpd = GROUP words BY word;
-- Count the occurence of each word (Reduce)
cntd = FOREACH grpd GENERATE $0, COUNT($1) As wordcount;
-- Store the result in HDFS
rmf hdfs:///user/ruchika/PigOutput1;
STORE cntd INTO 'hdfs:///user/ruchika/PigOutput1';