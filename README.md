# HNP_unramified_cover_computations

GAP code for computing the unramified cover of the first obstruction to HNP. The functions are in the GAP file unram.gap. We then used a HPC cluster to carry out the computations in degree 30 and 42. To do this, the bash file opens our virtual environment which has sage downloaded, and runs unram.gap in the in-built gap console in sage. The result of the computations is a list of all the possible Galois closure groups for extensions of degree 30 and 42 that can fail the Hasse norm principle.
