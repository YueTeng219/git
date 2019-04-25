##combine all txt to final_data(data.fram)
setwd("/Users/tengyue/Desktop/R_training")
getwd()
file_name<- list.files("RawData")[-1]
l1<- length(file_name)

setwd("/Users/tengyue/Desktop/R_training/RawData")
final_data<-read.table("K562_CL100050924_L02_49.txt")
for(i in 1:l1){
  read_data<-read.table(file=file_name[i])
  final_data<-rbind(final_data,read_data,deparse.level=0)
}

##replace ensembl_nub to ref_gene_name
ref=read.table("EnsDb.Hsapiens.v75.txt",sep="\t")
Switch <- function(final_data,c1){
  a<- substr(final_data[c1],1,15)
  index<- which(ref==a,arr.ind = T) 
  gsub(final_data[c1],ref[index[1],index[1,2]+7],final_data[c1])
}
change_data<-apply(final_data,1,Switch,c1="V1")
change_data<-as.data.frame(change_data)
final_data[,1]<-change_data


##get exon_length
Exon_length <- function(final_data,c1){
  a=as.character(final_data[c1])
  index<- which(ref==a,arr.ind = T) 
  (ref[index[1],index[1,2]+5])*10^(-3)
}
exon_length<-apply(final_data,1,Exon_length,c1="V1")
exon_length<-as.numeric(exon_length)
exon_length<-as.matrix(exon_length)
final_data<- cbind(final_data,exon_length)
mapped_reads=sum(final_data[,2])*10^(-7)


##get RPKM
RPKM<-data.frame(GENE_ID=final_data[,1],RPKM=final_data[,2]/(final_data[,3]*mapped_reads))


##select express_rate > 10%gene 
Effect_gene<-RPKM[RPKM[,2]>1,]
Effect_gene
