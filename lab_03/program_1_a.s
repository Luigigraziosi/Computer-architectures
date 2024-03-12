					.data
v1:					.double 1.0, 2.0, 3.0, 4.0
					.double 5.0, 6.0, 7.0, 8.0
					.double 9.0, 10.0, 11.0, 12.0
					.double 13.0, 14.0, 15.0, 16.0
					.double 17.0, 18.0, 19.0, 20.0
					.double 21.0, 22.0, 23.0, 24.0
					.double 25.0, 26.0, 27.0, 28.0
					.double 29.0, 30.0, 31.0, 32.0
					.double 33.0, 34.0, 35.0, 36.0
					.double 37.0, 38.0, 39.0, 40.0
					.double 41.0, 42.0, 43.0, 44.0
					.double 45.0, 46.0, 47.0, 48.0
					.double 49.0, 50.0, 51.0, 52.0
					.double 53.0, 54.0, 55.0, 56.0
					.double 57.0, 58.0, 59.0, 60.0
					.double 61.0, 62.0, 63.0, 64.0
v2:					.double 1.0, 2.0, 3.0, 4.0
					.double 5.0, 6.0, 7.0, 8.0
					.double 9.0, 10.0, 11.0, 12.0
					.double 13.0, 14.0, 15.0, 16.0
					.double 17.0, 18.0, 19.0, 20.0
					.double 21.0, 22.0, 23.0, 24.0
					.double 25.0, 26.0, 27.0, 28.0
					.double 29.0, 30.0, 31.0, 32.0
					.double 33.0, 34.0, 35.0, 36.0
					.double 37.0, 38.0, 39.0, 40.0
					.double 41.0, 42.0, 43.0, 44.0
					.double 45.0, 46.0, 47.0, 48.0
					.double 49.0, 50.0, 51.0, 52.0
					.double 53.0, 54.0, 55.0, 56.0
					.double 57.0, 58.0, 59.0, 60.0
					.double 61.0, 62.0, 63.0, 64.0
v3:					.double 1.0, 2.0, 3.0, 4.0
					.double 5.0, 6.0, 7.0, 8.0
					.double 9.0, 10.0, 11.0, 12.0
					.double 13.0, 14.0, 15.0, 16.0
					.double 17.0, 18.0, 19.0, 20.0
					.double 21.0, 22.0, 23.0, 24.0
					.double 25.0, 26.0, 27.0, 28.0
					.double 29.0, 30.0, 31.0, 32.0
					.double 33.0, 34.0, 35.0, 36.0
					.double 37.0, 38.0, 39.0, 40.0
					.double 41.0, 42.0, 43.0, 44.0
					.double 45.0, 46.0, 47.0, 48.0
					.double 49.0, 50.0, 51.0, 52.0
					.double 53.0, 54.0, 55.0, 56.0
					.double 57.0, 58.0, 59.0, 60.0
					.double 61.0, 62.0, 63.0, 64.0
v4:					.double 1.0, 2.0, 3.0, 4.0
					.double 5.0, 6.0, 7.0, 8.0
					.double 9.0, 10.0, 11.0, 12.0
					.double 13.0, 14.0, 15.0, 16.0
					.double 17.0, 18.0, 19.0, 20.0
					.double 21.0, 22.0, 23.0, 24.0
					.double 25.0, 26.0, 27.0, 28.0
					.double 29.0, 30.0, 31.0, 32.0
					.double 33.0, 34.0, 35.0, 36.0
					.double 37.0, 38.0, 39.0, 40.0
					.double 41.0, 42.0, 43.0, 44.0
					.double 45.0, 46.0, 47.0, 48.0
					.double 49.0, 50.0, 51.0, 52.0
					.double 53.0, 54.0, 55.0, 56.0
					.double 57.0, 58.0, 59.0, 60.0
					.double 61.0, 62.0, 63.0, 64.0
v5:					.space 512
v6:					.space 512
v7:					.space 512
					.text
main:				daddi r1, r0, 0
					daddi r2, r0, 0
					daddi r3, r0, 64
					daddi r4, r0, 1 
					daddi r6, r0, 1

					
					
ciclo:				andi r5, r2, 1 
					l.d f1, v1(r1)
					l.d f2, v2(r1)
					l.d f3, v3(r1)
					l.d f4, v4(r1)	
					
					beqz r5, pari				
dispari: 			
					
					cvt.l.d f13, f4
					mfc1 r7, f13
					dsllv r6, r6, r2
					ddiv r8, r7, r6
					

					mtc1 r4, f8
					cvt.d.l f8, f8
					mtc1 r2, f11
					cvt.d.l f11, f11
					mul.d  f8, f8, f11
					
					div.d f9, f1, f8	
					mtc1 r8, f10
					cvt.d.l f10, f10
					j operazioni

pari:				dsllv r4, r4, r2
					mtc1 r4, f8
					cvt.d.l f8, f8
					mul.d f9, f1, f8
					cvt.l.d f13, f9	
					mfc1 r4, f13

operazioni:			
					
					
					mul.d f5, f9, f2
					add.d f6, f1, f10
					daddi r2, r2, 1
					add.d f5, f5, f3
					add.d f7, f2, f3
					
					add.d f5, f5, f4
					div.d f6, f5, f6
					s.d f5, v5(r1)
					
					s.d f6, v6(r1)
					mul.d f7, f6, f7

					s.d f7, v7(r1)
					daddi r1, r1, 8
					bne r2, r3, ciclo
					halt