#!/usr/bin/env nextflow

nextflow.enable.dsl=2


ch_sras = Channel.fromSRA((params.sample_sheet | splitCsv(header:true) | map { row-> row.acc }), apiKey: params.apikey)

include { FETCH_SRA_PE as FETCH_SRA_PE } from './workflows/FETCH_SRA_PE.nf'
include { SR_MULTIQC as SR_MULTIQC } from './workflows/SR_MULTIQC.nf'


workflow {


    if (params.workflow_opt == 'paired') {

        FETCH_SRA_PE(ch_sras)

        }

    if (params.workflow_opt == 'multiqc') {

        SR_MULTIQC()

        }

}