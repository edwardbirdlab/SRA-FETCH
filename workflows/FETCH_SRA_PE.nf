/*
~~~~~~~~~~~~~~~~~~~~~~
Importing subworkflows
~~~~~~~~~~~~~~~~~~~~~~
*/

include { READ_QC_SR as READ_QC_SR } from '../subworkflows/READ_QC_SR.nf'


workflow FETCH_SRA_PE {
    take:
        ch_sras      //    channel: [val(accession)]

    main:

        READ_QC_SR(ch_sras)

}