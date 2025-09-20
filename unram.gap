Unram_cov_num:= function(d,j)
	# Computes (H \cap [G,G])/[H,H] where G is the jth transitive subgroup of S_d and H is the stabiliser in G of 1

    local G, H, pi_H, Hab; # local variables
	
	G:=TransitiveGroup(d,j); # the jth transitive subgroup of S_d
	H:=Stabilizer(G,1); # stabiliser in G of 1

	if DerivedSubgroup(H) = H then
		# if the abelianisation of H is trivial, then the quotient is trivial
		return Group(());
	fi;
	
	pi_H:=NaturalHomomorphismByNormalSubgroup(H,DerivedSubgroup(H)); # natural surjection H -> H/[H,H]
	Hab := Image(pi_H); # abelianisation of H

    if DerivedSubgroup(G)=G then
		# if abelianisation of G is trivial, then quotient is just the abelianisation of H
        return Hab;
    fi;

    return Image(pi_H,Intersection(H,DerivedSubgroup(G))); # output is just the image of H \cap [G,G] under the quotient map pi_H

end;

Unram_cov_denom:= function(d,j)
	# Computes Phi^G(H)/[H,H] where G is the jth transitive subgroup of S_d and H is the stabiliser in G of 1

    local G,H,pi_H,Hab,HGrep,denom_gen,h,x; # local variables

	G:=TransitiveGroup(d,j); # the jth transitive subgroup of S_d
	H:=Stabilizer(G,1); # stabiliser in G of 1

	pi_H:=NaturalHomomorphismByNormalSubgroup(H,DerivedSubgroup(H)); # natural surjection H -> H/[H,H]
	Hab := Image(pi_H); # abelianisation of H
    HGrep:=List(RightCosets(G,H),Representative); # list of representatives of right cosets of H in G

    denom_gen:=[];
    for x in HGrep do
        for h in GeneratorsOfGroup(Intersection(H,H^x)) do
            Add(denom_gen,Image(pi_H,Comm(h,x^-1)));
        od;
    od;
    return Group(denom_gen,Identity(Hab));

end;

FalseUnramObstList := function(d, index_start)
	# For a given degree d and index_start i, returns a csv file recording all the transitive subgroups of S_d, starting from the ith for which F(G,H) \neq 1

	local output, j, c, G, H, FGH_num, FGH_denom;
	c:=1;
    output := Concatenation("output_", String(d), "_from_", String(index_start), ".csv");
    PrintTo(output, "Count, j, Group, H1\n");

	for j in [index_start.. NrTransitiveGroups(d)] do
		G:=TransitiveGroup(d,j);
		H:=Stabilizer(G,1);
		if CommutatorSubgroup(Normalizer(H,G), H) <> Intersection(H, DerivedSubgroup(G)) then
			# if [N_G(H), H] = H \cap [G,G], then the unramified cover is trivial so make sure we are not in this case
			FGH_num := Unram_cov_num(d,j); # compute (H \cap [G,G])/[H,H]
			if Order(FGH_num) <> 1 then
			# if the numerator is not trivial compute Phi^G(H)/[H,H]
				FGH_denom := Unram_cov_denom(d,j);
				if Order(FGH_num) <> Order(FGH_denom) then # if (H \cap [G,G])/[H,H] is not the same as Phi^G(H)/[H,H]
					# print information about the group
                    AppendTo(output,
                        Concatenation(
                        String(c), ", ",
                        String(j), ", ",
                        "\"", StructureDescription(G), "\", ",
                        String(Order(FGH_num) / Order(FGH_denom)), "\n"
                        )
                    );
					c := c+1; # update counter
				fi;
			fi;
		fi;
	od; 
end;

# The below adapted function does the same as the above, but does not compute the isomorphism type of the group (since GAP gets stuck in high degrees) 

FalseUnramObstListNoSD := function(d, index_start)
	local output, j, c, G, H, FGH_num, FGH_denom;
	c:=1;
    output := Concatenation("output_", String(d), "_from_", String(index_start), "_no_SD.csv");
    PrintTo(output, "Count, j, H1\n");

	for j in [index_start.. NrTransitiveGroups(d)] do
		G:=TransitiveGroup(d,j);
		H:=Stabilizer(G,1);
		if CommutatorSubgroup(Normalizer(H,G), H) <> Intersection(H, DerivedSubgroup(G)) then
			# if [N_G(H), H] = H \cap [G,G], then the unramified cover is trivial so make sure we are not in this case
			FGH_num := Unram_cov_num(d,j); # compute (H \cap [G,G])/[H,H]
			if Order(FGH_num) <> 1 then
			# if the numerator is not trivial compute Phi^G(H)/[H,H]
				FGH_denom := Unram_cov_denom(d,j);
				if Order(FGH_num) <> Order(FGH_denom) then # if (H \cap [G,G])/[H,H] is not the same as Phi^G(H)/[H,H]
					# print information about the group
                    AppendTo(output,
                        Concatenation(
                        String(c), ", ",
                        String(j), ", ",
                        String(Order(FGH_num) / Order(FGH_denom)), "\n"
                        )
                    );
					c := c+1; # update counter
				fi;
			fi;
		fi;
	od; 
end;