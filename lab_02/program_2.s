					.data
v_i:				.double 0.40, 0.24, 0.37, 0.34, 0.97, 0.94, 0.26, 0.43, 0.71, 0.20, 0.03, 0.96, 0.91, 0.02, 0.19, 0.96, 0.58, 0.88, 0.15, 0.60, 0.21, 0.17, 0.31, 0.52, 0.31, 0.92, 0.77, 0.74, 0.12, 0.39
v_w:				.double 0.80, 0.31, 0.95, 0.08, 0.64, 0.23, 0.09, 0.95, 0.74, 0.62, 0.89, 0.39, 0.58, 0.81, 0.74, 0.55, 0.22, 0.47, 0.25, 0.98, 0.94, 0.03, 0.90, 0.24, 0.57, 0.46, 0.56, 0.51, 0.20, 0.53
b:					.word 0xAB
y:					.space 8
					.text
main:				dadd r1, r0, r0
					daddi r2, r0, 240 	; 30*8
					add.d f4, f0, f0	; x
					
ciclo:				l.d f1, v_i(r1)
					l.d f2, v_w(r1)
					
					mul.d f3, f1, f2
					add.d f4, f3, f4
					
					daddi r1, r1, 8
					bne r1, r2, ciclo
					
					l.d f5, b(r0)
					add.d f4, f4, f5
					
					mfc1 r1, f4
					dsll r1, r1, 1
					daddi r2, r0, 53
					dsrlv r1, r1, r2
					
					daddi r2, r0, 2047
					bne r1, r2, fine
					add.d f4, f0, f0
					
fine:				s.d f4, y(r0)
					halt
					