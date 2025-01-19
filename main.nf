#!/usr/bin/env nextflow

nextflow.enable.dsl=2


// Read the CSV file and extract the accession numbers as a list
accessions = file(params.sample_sheet).splitCsv()[1..-1]  // Skip the header row

// Fetch the SRA data using the accessions and the NCBI API key
reads = Channel.fromSRA(accessions.flatten(), apiKey: params.apikey)


//ch_sras = Channel.fromPath(params.sample_sheet) \
//    | splitCsv(header:true) \
//    | map { row-> row.acc }

include { FETCH_SRA_PE as FETCH_SRA_PE } from './workflows/FETCH_SRA_PE.nf'
include { SR_MULTIQC as SR_MULTIQC } from './workflows/SR_MULTIQC.nf'


workflow {


    if (params.workflow_opt == 'paired') {

        FETCH_SRA_PE(ch_fastqs)

        }

    if (params.workflow_opt == 'multiqc') {

        SR_MULTIQC()

        }

}