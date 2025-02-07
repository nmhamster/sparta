# 2d flow around a circle

seed	    	    12345
dimension   	    2
global              gridcut 0.0 comm/sort yes

boundary	    o r p

create_box  	    0 10 0 10 -0.5 0.5
create_grid 	    10 10 1 
balance_grid        rcb cell

global		    nrho 1.0 fnum 0.001

species		    air.species N O
mixture		    air N O vstream 100.0 0 0 

read_surf           data.circle origin 5 5 0 trans 0.0 2.0 0.0 &
                    scale 0.33 0.33 1 group 1
surf_collide	    1 diffuse 300.0 0.0
surf_modify         all collide 1

collide             vss air air.vss

fix		    in emit/face air xlo 

timestep 	    0.0001

#dump                2 image all 50 image.*.ppm type type pdiam 0.1 &
#                    surf proc 0.01 size 512 512 zoom 1.75
#dump_modify	    2 pad 4
 
stats		    100
stats_style	    step cpu np nattempt ncoll nscoll nscheck
run 		    500

move_surf           all trans -1 0 0
run 		    500

move_surf           all trans 0 -1 0
run 		    500

move_surf           all trans 1 0 0
run 		    500

move_surf           all trans 0 1 0
run 		    500
