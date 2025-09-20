Unram_cov_num:= function(G,H)
	# Computes (H \cap [G,G])/[H,H] where G is the jth transitive subgroup of S_d and H is the stabiliser in G of 1

    local pi_H, Hab; # local variables

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

Unram_cov_denom:= function(G,H)
	# Computes Phi^G(H)/[H,H] where G is the jth transitive subgroup of S_d and H is the stabiliser in G of 1

    local pi_H,Hab,HGrep,denom_gen,h,x; # local variables

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