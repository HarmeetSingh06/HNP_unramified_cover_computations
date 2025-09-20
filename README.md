# HNP_unramified_cover_computations

GAP code for computing the unramified cover of the first obstruction to HNP. The functions are in the GAP file unram.gap. We then used a HPC cluster to carry out the computations in degree 30 and 42. I'll explain each file:

- 'unram.gap' the main function here is FalseUnramObstList which takes as input a squarefree degree d and makes a csv file recording the possible Galois closure groups for degree d extensions that can fail HNP
- 'run_false_unram.sh' bash file that is used to run on a HPC cluster. It opens our virtual env sage_nx_tf which has sage downloaded, and runs FalseUnramObstList through the gap interface in sage on a degree the user inputs
- the ouput files are the result of the HPC computations. We note that for high degree transitive groups, GAP's 'StructureDescription' function times out, so the outputs for which we could not compute StructureDescription are saved in separate output files (thise ending in '_no_SD.csv')

Hence, the groups in output_30.csv together with those in output_30_from_5491_no_SD.csv provide a full list of all possible Galois closure groups for degree 30 extensions that fail HNP (similary for the output 42 files).
