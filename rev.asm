locals
dseg	segment
		pinkc		db	2
		orangec		db	2
		canmove		db	0
		thereismark		db	0
		eating		db	0
		eating1		db	0
		boardlen 	db	10
		boadlen	dw	10
		counter1	db	0
		counter		db	0
		ct			dw	1
		rt			dw	1
		current		dw	0
		count		db	0
		count1		db	0
		sizi		dw	30
		siz			db	30
		color		dw	11
		xforrow		dw	?
		yforrow		dw	?
		begint		dw	?
		lastrow		dw	?
		lastcol		dw	?
		player1		db	1
		player2		db  11
		currentX		dw	100
		topLeftX		dw	100
		currentY		dw	0
		putinrow		db	0
		putincol		db	0
		chr				db	?
		col	                dw	10
		row 		dw	10
		rowpix		dw	?
		lastrowpix	dw	?
		colpix		dw	?
		lastcolpix	dw	?
		board		db	0,	0,	0,	0,	0,	0,	0,	0,	0,	0
					db	0,	0,	0,	0,	0,	0,	0,	0,	0,	0
					db	0,	0,	0,	0,	0,	0,	0,	0,	0,	0
					db	0,	0,	0,	0,	0,	0,	0,	0,	0,	0
					db	0,	0,	0,	0,	1,	11,	0,	0,	0,	0
					db	0,	0,	0,	0,	11,	1,	0,	0,	0,	0
					db	0,	0,	0,	0,	0,	0,	0,	0,	0,	0
					db	0,	0,	0,	0,	0,	0,	0,	0,	0,	0
					db	0,	0,	0,	0,	0,	0,	0,	0,	0,	0
					db	0,	0,	0,	0,	0,	0,	0,	0,	0,	0
		lengthof		=	$-board
		board1		db	0,	0,	0,	0,	0,	0,	0,	0,	0,	0
					db	0,	0,	0,	0,	0,	0,	0,	0,	0,	0
					db	0,	0,	0,	0,	0,	0,	0,	0,	0,	0
					db	0,	0,	0,	0,	0,	0,	0,	0,	0,	0
					db	0,	0,	0,	0,	1,	11,	0,	0,	0,	0
					db	0,	0,	0,	0,	11,	1,	0,	0,	0,	0
					db	0,	0,	0,	0,	0,	0,	0,	0,	0,	0
					db	0,	0,	0,	0,	0,	0,	0,	0,	0,	0
					db	0,	0,	0,	0,	0,	0,	0,	0,	0,	0
					db	0,	0,	0,	0,	0,	0,	0,	0,	0,	0		
		cursor		db	25, 255
					db	5, 1, 19, 255
					db	5, 2, 18, 255
					db	5, 3, 17, 255
					db	5, 4, 16, 255
					db	5, 5, 15, 255
					db	5, 6, 14, 255
					db	5, 7, 13, 255
					db	5, 8, 12, 255
					db	5, 9, 11, 255
					db	5, 10, 10, 255
					db	5, 11, 9, 255
					db	5, 12, 8, 255
					db	5, 13, 7, 255
					db	5, 14, 6, 255
					db	5, 5, 1, 2, 12, 255
					db	5, 4, 2, 2, 12, 255
					db	5, 3, 4, 2, 11, 255
					db	5, 2, 5, 2, 11, 255
					db	5, 1, 7, 2, 10, 255
					db	13, 2, 10, 255
					db	14, 2, 9, 255
					db	14, 2, 9, 255
					db	25, 255
					db	25, 254
dseg	ends
Cseg	Segment
Assume	cs:Cseg,	ds:dseg	
UpdateBoard	proc
			mov putinrow, 0
			mov putincol, 0
			mov	bx,	0
			mov count, 0
			mov	counter, 0
			mov current, 0
			mov si,	-1
			dec	putincol
			jmp	Screen
	UpdateScreen:
			mov putincol, -1
			mov	bx,	current
			add	bx,	boadlen
			mov	current, bx
			inc count
			inc putinrow
			mov al,	count			
			mov	si,	-1	
			cmp	al, boardlen
			jc Screen
			jmp Sof
	Screen:	inc	si
			mov bx, current
			inc	putincol
			cmp	si,	boadlen
			jnc	UpdateScreen
			cmp board1[bx+si],	0
			jz Screen
	Check1:	mov	dl,	5
			cmp board1[bx+si],	11
			jnc	Bupdate
			mov dl, 7
			cmp board1[bx+si], 7
			jz Bupdate
			mov	dl, 6
			
			
	Bupdate:mov	rt,	1
			mov	ct,	1
			mov	di,	begint
			inc di
			mov ax, sizi
			mov bl, putincol
			mul bl
			add di, ax
			mov	colpix,	di
			mov	currentX,	di

			mov	di,	begint
			inc di
			mov ax, sizi
			mov bl, putinrow
			mul bl
			add di, ax
			mov	rowpix,	di
			mov	currentY,	di
			dec	currentY
			mov counter, 0
			mov counter1, 0

			mov al, dl
			mov bx, 0
	@@Again:  mov	ct,	1
			inc currentY
			mov di, colpix
			mov currentX, di			
	@@Color1:
			mov ah,	0ch
			mov	cx,	currentX
			mov	dx,	currentY
			int	10h
			inc	currentX
			inc ct
			mov	di,	ct
			cmp di, sizi
			jc	@@Color1
			inc	rt
			mov	di,	rt
			cmp	di,	sizi
			jc	 @@Again
			jmp Screen
			Sof:
			mov si, 0
	Cleans:	mov board1[si], 0
			inc si
			cmp si, lengthof 
			jnz Cleans
			ret
UpdateBoard	endp
Marking	proc
			mov canmove, 0
			mov bx,0	; adds to row the boadlen
			mov count, 0	; counts - rows
			mov	current, 0	; interger for row	
			mov si, -1
			jmp Shoov1
	Shoov:	mov si, -1	; counts - cols
			inc count	; inc row count
			mov bx, current	;	updated row
			add	bx,	boadlen	;	row++
			mov	current, bx	;	saves updated row	
			mov	al,	count	
			cmp al,	boardlen	
			jc	Shoov1	; (row<board.gl(0))
			jmp HHere
	Shoov1: mov bx, current
			inc	si	;	colcounter
			cmp	si,	boadlen
			jz	Shoov	; (col<a.gl(1))
			mov al, player1	; 1 or 11
			cmp board[bx+si], al	
			jnz Shoov1	; if (board[r,c]==player)
			add	bx,	si

	CheckDown:		
			mov al, boardlen
			sub al, 2
			cmp count, al 
			jnc	CheckUp ; if (r<a.GL(0)-2)
			mov ah, player2 
			mov di, boadlen
			cmp	board[bx+di], ah ; (&& board[r+1,c]==player2)
			jnz CheckUp ; if not CheckUp
			mov al, count ; row counter
			mov count1, al ; so the real row counter won't change
			inc count1
	ChDown:	add	di,	boadlen
			inc count1
			mov dl, boardlen
			cmp count1, dl
			jnc	CheckUp ; if (sh>=a.gl(0) break)
			mov dl, player1
			cmp board[bx+di], dl
			jz CheckUp ;	a[sh, d] != player1
			mov dl,	7
			cmp	board[bx+di], dl
			jz	CheckUp ; a[sh, d] != 4
			cmp board[bx+di], 0
			jnz Chdown
			mov board[bx+di], 7
			mov board1[bx+di], 7
			inc canmove
	CheckUp:cmp count, 2
			jc	CheckRight ; if (r>1)
			mov ah, player2 
			mov di, 0
			sub di, boadlen
			cmp	board[bx+di], ah ; (&& board[r-1,c]==player2)
			jnz CheckRight ; if not CheckUp
			mov al, count ; row counter
			mov count1, al ; so the real row counter won't change
			dec count1
	ChUp:	sub	di,	boadlen
			dec count1
			cmp count1, -1
			jz	CheckRight ; if (sh<0 break)
			mov dl, player1
			cmp board[bx+di], dl
			jz CheckRight ;	a[sh, d] != player1
			mov dl,	7
			cmp	board[bx+di], dl
			jz	CheckRight ; a[sh, d] != 4
			cmp board[bx+di], 0
			jnz ChUp
			mov board[bx+di], 7
			mov board1[bx+di], 7
			inc canmove
	CheckRight:
			mov ax, boadlen
			sub ax, 2
			cmp si, ax
			jnc	CheckLeft ; if (r<a.GL(0)-2)
			mov	bx,	current
			mov ah, player2 
			mov di, si
			inc di
			cmp	board[bx+di], ah ; (&& board[r,c+1]==player2)
			jnz CheckLeft ; if not CheckUp			
	ChRight:
			inc di
			mov dx, boadlen
			cmp di, dx
			jz	CheckLeft ; if (c>=a.gl(0) break)
			mov dl, player1
			cmp board[bx+di], dl
			jz CheckLeft ;	a[sh, d] != player1
			mov dl,	7
			cmp	board[bx+di], dl
			jz	CheckLeft ; a[sh, d] != 4
			cmp board[bx+di], 0
			jnz ChRight
			mov board[bx+di], 7
			mov board1[bx+di], 7
			inc canmove
	CheckLeft:
			mov	bx,	current
			cmp si, 2
			jc	CheckDownRight ; if (r<a.GL(0)-2)
			mov ah, player2 
			mov di, si
			dec di
			cmp	board[bx+di], ah ; (&& board[r,c+1]==player2)
			jnz CheckDownRight ; if not CheckUp			
	ChLeft:
			dec di
			cmp di, -1
			jz	CheckDownRight ; if (c>=a.gl(0) break)
			mov dl, player1
			cmp board[bx+di], dl
			jz CheckDownRight ;	a[sh, d] != player1
			mov dl,	7
			cmp	board[bx+di], dl
			jz	CheckDownRight ; a[sh, d] != 4
			cmp board[bx+di], 0
			jnz ChLeft
			mov board[bx+di], 7
			mov board1[bx+di], 7
			inc canmove
		CheckDownRight:
			mov al, boardlen
			sub al, 2
			cmp count, al 
			jnc	CheckUpLeft ; if (r<a.GL(0)-2)
			mov ax, boadlen
			sub ax, 2
			cmp si, ax
			jnc	CheckUpLeft ; if (r<a.GL(0)-2)
			mov ah, player2 
			add bx, boadlen
			mov di, si
			inc di
			cmp	board[bx+di], ah ; (&& board[r+1,c+1]==player2)
			jnz CheckUpLeft ; if not CheckUpLeft
			mov al, count ; row counter
			mov count1, al ; so the real row counter won't change
			inc count1
	ChDownRight:	
			add	bx,	boadlen
			inc di
			inc count1
			mov dl, boardlen
			cmp count1, dl
			jnc	CheckUpLeft ; if (sh>=a.gl(0) break)
			cmp di, boadlen
			jnc	CheckUpLeft ; if (c>=a.gl(0) break)
			mov dl, player1
			cmp board[bx+di], dl
			jz CheckUpLeft ;	a[sh, d] != player1
			mov dl,	7
			cmp	board[bx+di], dl
			jz	CheckUpLeft ; a[sh, d] != 4
			cmp board[bx+di], 0
			jnz ChDownRight
			mov board[bx+di], 7
			mov board1[bx+di], 7
			inc canmove
		CheckUpLeft:
			mov bx, current
			cmp count, 2
			jc	CheckUpRight ; if (r>1)
			cmp si, 2
			jc	CheckUpRight ; if (c>1)			
			mov ah, player2 
			sub bx, boadlen
			mov di, si
			dec di
			cmp	board[bx+di], ah ; (&& board[r-1,c-1]==player2)
			jnz CheckUpRight ; if not CheckUpLeft
			mov al, count ; row counter
			mov count1, al ; so the real row counter won't change
			dec count1
	ChUpLeft:	
			sub	bx,	boadlen
			dec di
			dec count1
			cmp count1, -1
			jz	CheckUpRight ; if (sh<0 break)
			cmp di, -1
			jz	CheckUpRight ; if (c>=a.gl(0) break)
			mov dl, player1
			cmp board[bx+di], dl
			jz CheckUpRight ;	a[sh, d] != player1
			mov dl,	7
			cmp	board[bx+di], dl
			jz	CheckUpRight ; a[sh, d] != 4
			cmp board[bx+di], 0
			jnz ChUpLeft
			mov board[bx+di], 7
			mov board1[bx+di], 7
			inc canmove
	CheckUpRight:
			cmp count, 2
			jc	CheckDownLeft ; if (r>1)
			mov ax, boadlen
			sub ax, 2
			cmp si, ax
			jnc	CheckDownLeft ; while (r<a.GL(0)-2)	
			mov ah, player2 
			mov bx, current
			sub bx, boadlen
			mov di, si
			inc di
			cmp	board[bx+di], ah ; (&& board[r-1,c-1]==player2)
			jnz CheckDownLeft ; if not CheckUpLeft
			mov al, count ; row counter
			mov count1, al ; so the real row counter won't change
			dec count1
	ChUpRight:	
			sub	bx,	boadlen
			inc di
			dec count1
			cmp count1, -1
			jz	CheckDownLeft ; if (sh<0 break)
			cmp di, boadlen
			jz	CheckDownLeft ; if (c>=a.gl(0) break)
			mov dl, player1
			cmp board[bx+di], dl
			jz CheckDownLeft ;	a[sh, d] != player1
			mov dl,	7
			cmp	board[bx+di], dl
			jz	CheckDownLeft ; a[sh, d] != 4
			cmp board[bx+di], 0
			jnz ChUpRight
			mov board[bx+di], 7
			mov board1[bx+di], 7
			inc canmove
	CheckDownLeft:
			mov bx,current
			mov al, boardlen
			sub al, 2
			cmp count, al 
			jnc	Sofit ; if (r<a.GL(0)-2)
			cmp si, 2
			jc	Sofit ; if (c>1)		
			mov ah, player2 
			add bx, boadlen
			mov di, si
			dec di
			cmp	board[bx+di], ah ; (&& board[r+1,c+1]==player2)
			jnz Sofit ; if not CheckUpLeft
			mov al, count ; row counter
			mov count1, al ; so the real row counter won't change
			inc count1
	ChDownLeft:	
			add	bx,	boadlen
			dec di
			inc count1
			mov dl, boardlen
			cmp count1, dl
			jz	Sofit ; if (sh>=a.gl(0) break)
			cmp di, -1
			jz	Sofit ; if (c>=a.gl(0) break)
			mov dl, player1
			cmp board[bx+di], dl
			jz Sofit ;	a[sh, d] != player1
			mov dl,	7
			cmp	board[bx+di], dl
			jz	Sofit ; a[sh, d] != 4
			cmp board[bx+di], 0
			jnz ChDownLeft
			mov board[bx+di], 7
			mov board1[bx+di], 7
			inc canmove
	Sofit:
	jmp		Shoov1
	HHere:  mov dl, 0
			cmp canmove, dl
			jnz zersof
			cmp thereismark, 2
			jz WhoWon
			inc thereismark
			cmp thereismark, 2
			jnz @@Sof
	WhoWon: mov dl, pinkc
			cmp orangec, dl
			jz IteATie
			cmp orangec, dl
			ja TheOWon
			mov orangec, 0
			jmp Sof
	TheOWon:
			mov pinkc, 0
			jmp Sof
	IteATie:
			mov orangec,0
			mov pinkc, 0
			jmp Sof
	zersof:
			mov thereismark, 0
	@@Sof:
			ret
Marking		endp
PlaceCursor	proc
			mov si, 0
			mov bx, 0 
			mov ax, 0
	@@PutCursor: 
			cmp board[si+bx], 7
			jz @@Go2
			inc si
			cmp si, boadlen
			jnz @@PutCursor
			mov si, 0
			inc ah
			add al, boardlen
			add bx, boadlen
			cmp ah, boardlen
			jnz @@PutCursor
			mov al, 's'
			jmp @@outof
	@@Go2:
			mov ah, 0
			mov bl, 10
			div bl
			mov putinrow, al
			mov bx, si
			mov putincol, bl

			mov	di,	begint
			inc di
			mov	cl,	0
			mov  ax, sizi
			mov bl, putincol
			mul bl
			mov bx, ax
			add	di,	bx
			mov	colpix,	di
			mov	currentX,	di
			mov topleftx, di
			mov	cl,	0
			mov	di,	begint
			inc di
			mov ax, sizi
			mov bl, putinrow
			mul bl
			mov bx, ax
			add	di,	bx			
			mov	rowpix,	di
			mov	currentY,	di



			mov	si,	-1
			mov al, 0
			mov bh,	0h
			mov ah,	0ch
			mov bl, 0
	@@Again: 
			inc currentY
	        inc si
			mov di, topleftx
			mov currentX, di
	@@Color1:	inc	currentX
			inc bl
			mov dh, bl
			cmp	dh, cursor[si]
			jnz @@Color1
			inc si
		    mov	bl, 0
			cmp cursor[si], 0ffh
			jz @@Again
		    cmp cursor[si], 0feh
			jz @@Outof
	@@Color2: 
			mov	cx,	currentX
			mov	dx,	currentY
			int	10h
			inc	currentX
			inc bl
			mov dh, bl
			cmp	dh, cursor[si]
			jnz @@Color2
			inc si
			mov bl, 0
			cmp cursor[si], 0ffh
			jz @@Again
			cmp cursor[si], 0feh
			jnz @@Color1
	@@Outof:	
			ret
PlaceCursor	endp
CursorMovement proc
              cmp al, 's'
			  jnz Begin
		Loopi:   mov ah, 7
			  int 21h
			   cmp al, 's'
			  jnz CheckIfOutOfGame
			  jmp @@Ending
		CheckIfOutOfGame:
			  cmp al, 27
			  jnz Loopi
			  jmp @@Ending

Begin:        
	  		  mov ah, 7
			  int 21h
			  mov chr, al
			  cmp al, 'a'
			  jz CheckSide
			  cmp al, 'd'
			  jz CheckSide		
			  cmp al, ' '
			  jnz Skip			  
			  jmp @@Ending
	Skip:	  cmp al, 's'
			  jnz Winn
			  jmp @@Ending
	Winn:     cmp al, 27
	          jnz Begin
			  jmp @@Ending

			CheckSide:
			mov al, boardlen
			mov bl, putinrow
			mul bl
			mov bx, ax
			mov ah, 0
			mov al, putincol
			mov si, ax
			mov ah, putinrow
			mov al, bl
			mov di, rowpix
			mov lastrowpix, di
			mov di, colpix
			mov lastcolpix, di
			mov di, si
			mov dx, bx
			mov cl, al
			mov ch, ah
			dec si
			cmp si, -1
			jnz	Cont
			mov si, boadlen
			dec si
			sub bx, boadlen
			dec ah
			sub al, boardlen
			cmp bx, -10
			jnz Cont
			mov bx, lengthof
			sub bx, boadlen
			mov al, bl
			mov ah, boardlen
			dec ah
	Cont:
			cmp chr, 'a'
			jz @@PutCursorL
			mov bx, dx
			mov si, di
			mov al, cl
			mov ah, ch
			inc si
			cmp si, boadlen
			jnz @@PutCursorR
			mov si, 0
			add bx, boadlen
			inc ah
			add al, boardlen
			cmp bx, lengthof
			jnz @@PutCursorR
			mov bx, 0
			mov al, bl
			mov ah, 0
			@@PutCursorR: 
			cmp board[si+bx], 7
			jz @@Go3
			inc si
			cmp si, boadlen
			jnz @@PutCursorR
			mov si, 0
			inc ah
			add al, boardlen
			add bx, boadlen
			cmp ah, boardlen
			jnz @@PutCursorR
			mov	si,	0
			mov bx, 0
			mov ah, 0
			mov al, 0
			jmp @@PutCursorR


			@@PutCursorL: 
			cmp board[si+bx], 7
			jz @@Go3
			dec si
			cmp si, -1
			jnz @@PutCursorL
			mov si, boadlen
			dec si
			dec ah
			sub al, boardlen
			sub bx, boadlen
			cmp ah, -1
			jnz @@PutCursorL
			mov	si,	boadlen
			dec si
			mov bl, boardlen
			mov ax, 0
			mov al, boardlen
			dec al
			mul bl
			mov bx, ax
			mov al, bl
			mov ah, 10
			jmp @@PutCursorL
	@@Go3:
			mov ah, 0
			mov bl, 10
			div bl
			mov putinrow, al
			mov bx, si
			mov putincol, bl

			mov	di,	begint
			inc di
			mov	cl,	0
			jmp @@checkin
	@@addin:	add	di,	sizi
			inc	cl
	@@checkin:cmp	cl,	putincol
			jnz	@@addin
			mov	colpix,	di
			mov	currentX,	di
			mov topleftx, di
			mov	cl,	0
			mov	di,	begint
			inc di
			jmp	@@checkinit
	@@addinit:		add	di,	sizi
			inc	cl
	@@checkinit:		cmp	cl,	putinrow
			jnz	@@addinit	
			mov	rowpix,	di
			mov	currentY,	di

			

			mov	si,	-1
			mov al, 0
			mov bh,	0h
			mov ah,	0ch
			mov bl, 0
	@@Again: 
			inc currentY
	        inc si
			mov di, topleftx
			mov currentX, di
	@@Color1:	inc	currentX
			inc bl
			mov dh, bl
			cmp	dh, cursor[si]
			jnz @@Color1
			inc si
		    mov	bl, 0
			cmp cursor[si], 0ffh
			jz @@Again
		    cmp cursor[si], 0feh
			jz @@Outof
	@@Color2: 
			mov	cx,	currentX
			mov	dx,	currentY
			int	10h
			inc	currentX
			inc bl
			mov dh, bl
			cmp	dh, cursor[si]
			jnz @@Color2
			inc si
			mov bl, 0
			cmp cursor[si], 0ffh
			jz @@Again
			cmp cursor[si], 0feh
			jnz @@Color1
	@@Outof:
			mov	di,	lastrowpix
			mov	currentY,	di
			dec	currentY
			mov	si,	1
			mov	rt,	1
			mov al, 7
	@@Shoov: mov	si,	1
			inc currentY
			mov di, lastcolpix
			mov currentX, di			
	@@Color0:
			mov bh,	0h
			mov ah,	0ch
			mov	cx,	currentX
			mov	dx,	currentY
			int	10h
			inc	currentX
			inc si
			cmp si, sizi
			jc	@@Color0
			inc	rt
			mov	di,	rt
			cmp	di,	sizi
			jc	 @@Shoov
	@@Returnn:
			jmp Begin
	@@Ending:
			ret
CursorMovement endp
Movement		proc
            cmp al, 's'
			jnz Rest
			jmp @@Sof
	Rest:	
		    mov ax, 0
			mov al, putincol ; al =c
			mov si, ax ; si = c
			mov al, putinrow ;al=r
            mov bl, boardlen ; bx= 10
			mul bl ;al*bl
			mov bx, ax ; bx = 10r
			mov di, bx
			mov ah, putinrow
			mov cl, player2 
			mov ch, player1
			mov board[bx+si], ch ; instead of 7 >> board[r,c]=player1
			mov board1[bx+si], ch
			mov dl, boardlen 
			sub dl, 2 ; cl = b.gl(0)-2
			cmp ah, dl 
			jnc @@IfCheckUp ; if (r>=b.gl(0)-2) break
			add bx, boadlen
			inc ah
	     	cmp board[bx+si], cl ; board[r,c]?= player2
			jnz @@IfCheckUp
	@@CheckDown:
			add bx, boadlen
			inc ah
			cmp ah, boardlen
			jz @@IfCheckUp
			cmp board[bx+si], cl ; i
			jz @@CheckDown
			cmp board[bx+si], ch
			jnz @@IfCheckUp
	@@Down: dec ah
			sub bx, boadlen
			cmp ah, putinrow
			jz @@IfCheckUp
			mov board[bx+si], ch
			mov board1[bx+si], ch
			inc eating
			jmp @@Down
			
	@@IfCheckUp:
			mov bx, di
			mov ah, putinrow
			cmp ah, 2
			jc @@IfCheckRight
			sub bx, boadlen
			dec ah
			cmp board[bx+si], cl ; board[r,c]?= player2
			jnz @@IfCheckRight
	@@CheckUp:
			sub bx, boadlen
			dec ah
			cmp ah, -1
			jz @@IfCheckRight
			cmp board[bx+si], cl ; board[r,c]?= player2
			jz @@CheckUp
			cmp board[bx+si], ch
			jnz @@IfCheckRight
	@@Up: inc ah
			add bx, boadlen
			cmp ah, putinrow
			jz @@IfCheckRight
			mov board[bx+si], ch
			mov board1[bx+si], ch
			inc eating
			jmp @@Up
	@@IfCheckRight:	
			mov bx, di
			mov dx, boadlen 
			sub dx, 2 ; dx = b.gl(0)-2
			cmp si, dx 
			jnc @@IfCheckLeft ; if (r>=b.gl(0)-2) break
			inc si
	     	cmp board[bx+si], cl ; board[r,c]?= player2
			jnz @@IfCheckLeft
	@@CheckRight:
			inc si
			cmp si, boadlen
			jz @@IfCheckLeft
			cmp board[bx+si], cl ; i
			jz @@CheckRight
			cmp board[bx+si], ch
			jnz @@IfCheckLeft
	@@Right: dec si
			mov dx, si
			cmp dl, putincol
			jz @@IfCheckLeft
			mov board[bx+si], ch
			mov board1[bx+si], ch
			inc eating
			jmp @@Right
	@@IfCheckLeft:
			mov ax, 0
			mov al, putincol
			mov si, ax
			cmp si, 2
			jc @@IfCheckDownRight
			dec si
			cmp board[bx+si], cl ; board[r,c]?= player2
			jnz @@IfCheckDownRight
	@@CheckLeft:
			dec si
			cmp si, -1
			jz @@IfCheckDownRight
			cmp board[bx+si], cl ; board[r,c]?= player2
			jz @@CheckLeft
			cmp board[bx+si], ch
			jnz @@IfCheckDownRight
	@@Left:	inc si
			mov ax, si
			cmp al, putincol
			jz @@IfCheckDownRight
			mov board[bx+si], ch
			mov board1[bx+si], ch
			inc eating
			jmp @@Left
	@@IfCheckDownRight:
			mov ax, 0
			mov al, putincol
			mov si, ax
			mov dx, boadlen 
			sub dx, 2 ; dx = b.gl(0)-2
			cmp si, dx 
			jnc @@IfCheckUpLeft ; if (r>=b.gl(0)-2) break
			mov ah, putinrow
			mov dl, boardlen 
			sub dl, 2 ; cl = b.gl(0)-2
			cmp ah, dl 
			jnc @@IfCheckUpLeft ; if (r>=b.gl(0)-2) break
			add bx, boadlen
			inc si
			inc ah
	     	cmp board[bx+si], cl ; board[r,c]?= player2
			jnz @@IfCheckUpLeft
	@@CheckDownRight:
			add bx, boadlen
			inc ah
			cmp ah, boardlen
			jz @@IfCheckUpLeft
			inc si
			cmp si, boadlen
			jz @@IfCheckUpLeft
			cmp board[bx+si], cl ; i
			jz @@CheckDownRight
			cmp board[bx+si], ch
			jnz @@IfCheckUpLeft
	@@DownRight:
			dec ah
			sub bx, boadlen
			cmp ah, putinrow
			jz @@IfCheckUpLeft
			dec si
			mov dx, si
			cmp dl, putincol
			jz @@IfCheckUpLeft
			mov board[bx+si], ch
			mov board1[bx+si], ch
			inc eating
			jmp @@DownRight
	@@IfCheckUpLeft:
			mov ax, 0
			mov al, putincol
			mov si, ax
			cmp si, 2
			jc @@IfCheckUpRight
			mov bx, di
			mov ah, putinrow
			cmp ah, 2
			jc @@IfCheckUpRight
			dec si
			sub bx, boadlen
			dec ah
			cmp board[bx+si], cl ; board[r,c]?= player2
			jnz @@IfCheckUpRight
	@@CheckUpLeft:
			sub bx, boadlen
			dec ah
			cmp ah, -1
			jz @@IfCheckUpRight
			dec si
			cmp si, -1
			jz @@IfCheckUpRight
			cmp board[bx+si], cl ; board[r,c]?= player2
			jz @@CheckUpLeft
			cmp board[bx+si], ch
			jnz @@IfCheckUpRight
	@@UpLeft:
			inc si
			mov ax, si
			cmp al, putincol
			jz @@IfCheckUpRight
			inc ah
			add bx, boadlen
			cmp ah, putinrow
			jz @@IfCheckUpRight
			mov board[bx+si], ch
			mov board1[bx+si], ch
			inc eating
			jmp @@UpLeft
	@@IfCheckUpRight:
			mov ax, 0
			mov al, putincol
			mov si, ax
			mov dx, boadlen 
			sub dx, 2 ; dx = b.gl(0)-2
			cmp si, dx 
			jnc @@IfCheckDownLeft ; if (r>=b.gl(0)-2) break
			mov bx, di
			mov ah, putinrow
			cmp ah, 2
			jc @@IfCheckDownLeft
			inc si
			sub bx, boadlen
			dec ah
			cmp board[bx+si], cl ; board[r,c]?= player2
			jnz @@IfCheckDownLeft
	@@CheckUpRight:
			sub bx, boadlen
			dec ah
			cmp ah, -1
			jz @@IfCheckDownLeft
			inc si
			cmp si, boadlen
			jz @@IfCheckDownLeft
			cmp board[bx+si], cl ; board[r,c]?= player2
			jz @@CheckUpRight
			cmp board[bx+si], ch
			jnz @@IfCheckDownLeft
	@@UpRight:
			dec si
			mov dx, si
			cmp dl, putincol
			jz @@IfCheckDownLeft
			inc ah
			add bx, boadlen
			cmp ah, putinrow
			jz @@IfCheckDownLeft
			mov board[bx+si], ch
			mov board1[bx+si], ch
			inc eating
			jmp @@UpRight

	@@IfCheckDownLeft:
			mov ax, 0
			mov al, putincol
			mov si, ax
			cmp si, 2
			jc @@Sof
			mov bx, di
			mov ah, putinrow
			mov dl, boardlen 
			sub dl, 2 ; cl = b.gl(0)-2
			cmp ah, dl 
			jnc @@Sof ; if (r>=b.gl(0)-2) break
			add bx, boadlen
			inc ah
			dec si
			cmp board[bx+si], cl ; board[r,c]?= player2
			jnz @@Sof
	@@CheckDownLeft:
			add bx, boadlen
			inc ah
			cmp ah, boardlen
			jz @@Sof
			dec si
			cmp si, -1
			jz @@Sof
			cmp board[bx+si], cl ; board[r,c]?= player2
			jz @@CheckDownLeft
			cmp board[bx+si], ch
			jnz @@Sof
	@@DownLeft:
			inc si
			mov ax, si
			cmp al, putincol
			jz @@Sof
			dec ah
			sub bx, boadlen
			cmp ah, putinrow
			jz @@Sof
			mov board[bx+si], ch
			mov board1[bx+si], ch
			inc eating
			jmp @@DownLeft

	@@Sof:				mov putinrow, 0
			mov bx, 0
			mov current, bx
			mov putincol,-1
			mov si, -1
			jmp Again0
			mov counter, 0

		Shoov0:
			mov si, -1
			mov putincol, -1
			inc putinrow
			inc counter
			mov bx, current
			add bx, boadlen
			mov current, bx
			mov bl, counter
			cmp bl, boardlen
			jnz Again0
			jmp @@Ending
		Again0:
			inc si
			inc putincol
			cmp si, boadlen
			jz Shoov0
			mov bx, current
			cmp board[bx+si], 7
			jnz Again0
			mov board[bx+si], 0
			mov board1[bx+si], 0
			mov	di,	begint
			inc di
			mov ax, sizi
			mov bl, putincol
			mul bl
			add di, ax
			mov	colpix,	di
			mov	currentX,	di

			mov	di,	begint
			inc di
			mov ax, sizi
			mov bl, putinrow
			mul bl
			add di, ax
			mov	rowpix,	di
			mov	currentY,	di
			dec	currentY

			mov rt, 1
			mov al, 0
			mov bx, 0
	Again3:	mov	ct,	1
			inc currentY
			mov di, colpix
			mov currentX, di			
	UpdateB:
			mov ah,	0ch
			mov	cx,	currentX
			mov	dx,	currentY
			int	10h
			inc	currentX
			inc ct
			mov	di,	ct
			cmp di, sizi
			jc	UpdateB
			inc	rt
			mov	di,	rt
			cmp	di,	sizi
			jc	Again3
			jmp Again0
		
	@@Ending: cmp al, 27
	         jz TheEnd
			call UpdateBoard
			cmp eating, 0
			jz TheEnd
			mov cl, eating
			mov eating1, cl
			inc eating1
	TheEnd:	
			ret
Movement		endp

	Start:
			mov	ax,	dseg
			mov	ds,	ax
			mov	ah,	0
			mov	di,	currentX
			mov	xforrow,	di
			mov yforrow,	di
			mov begint,		di
			mov	al,	12h
			int	10h
			mov	counter,	0
			mov	counter1,	-1

			mov	bx,	0
			mov	dx,	yforrow; ערך שורה
	
	rowloop:	
		
			push bx	; הופך לאפס
			mov	al,	7 ; צבע 
			mov	bh,	0h	; עמוד
			mov	ah,	0ch	; 
			mov	cx, 	xforrow	; ערך עמודה
			int	10h ;צובע
			mov	cx, 	dx
			push	dx
			mov	dx,	xforrow
			int	10h ;צובע
			pop	dx	; מחזיר אתת הערך ווי פור רו
			pop	bx  ; מחזיר את אפס
			inc	bx ; מעלה באחד
			inc	xforrow ; מעלה באחד
			cmp	bx,	sizi ;
			jnz	rowloop
			mov	bx,	0
			inc	counter
			mov al, counter
			cmp	al,	boardlen
			jc	rowloop
			mov	counter,	0
			mov di, CurrentX
			mov	xforrow,	di
			inc	counter1
			add	dx,	sizi
			mov al, counter1
			cmp	al,	boardlen
			jc	rowloop

	     mov ah, 2
		 mov dh, 4 ; row
	     mov dl, 45 ; col
		 int 10h
	     mov dl, 's'
		 int 21h
		 mov dl, ' '
		 int 21h
		 mov dl, '='
		 int 21h
		 mov dl, ' '
		 int 21h
		 mov dl, 's'
		 int 21h
		 mov dl, 'k'
		 int 21h
		 mov dl, 'i'
		 int 21h
		 mov dl, 'p'
		 int 21h
		  mov dl, ' '
		 int 21h
		  mov dl, 't'
		 int 21h
		  mov dl, 'u'
		 int 21h
		  mov dl, 'r'
		 int 21h
		  mov dl, 'n'
		 int 21h
		 mov dh, 2 ; row
	     mov dl, 45 ; col
		 int 10h
	     mov dl, 'a'
		 int 21h
		 mov dl, ' '
		 int 21h
		 mov dl, '='
		 int 21h
		 mov dl, ' '
		 int 21h
		 mov dl, 'm'
		 int 21h
		 mov dl, 'o'
		 int 21h
		 mov dl, 'v'
		 int 21h
		 mov dl, 'e'
		 int 21h
		  mov dl, ' '
		 int 21h
		  mov dl, 'l'
		 int 21h
		  mov dl, 'e'
		 int 21h
		  mov dl, 'f'
		 int 21h
		  mov dl, 't'
		 int 21h
		 		 mov dh, 3 ; row
	     mov dl, 45 ; col
		 int 10h
	     mov dl, 'd'
		 int 21h
		 mov dl, ' '
		 int 21h
		 mov dl, '='
		 int 21h
		 mov dl, ' '
		 int 21h
		 mov dl, 'm'
		 int 21h
		 mov dl, 'o'
		 int 21h
		 mov dl, 'v'
		 int 21h
		 mov dl, 'e'
		 int 21h
		  mov dl, ' '
		 int 21h
		  mov dl, 'r'
		 int 21h
		  mov dl, 'i'
		 int 21h
		  mov dl, 'g'
		 int 21h
		   mov dl, 'h'
		 int 21h
		  mov dl, 't'
		 int 21h
		 		 mov dh, 1 ; row
	     mov dl, 45 ; col
		 int 10h
	     mov dl, 'P'
		 int 21h
		 mov dl, 'r'
		 int 21h
		 mov dl, 'e'
		 int 21h
		 mov dl, 's'
		 int 21h
		 mov dl, 's'
		 int 21h
		 mov dl, ' '
		 int 21h
		 mov dl, 's'
		 int 21h
		 mov dl, 'p'
		 int 21h
		  mov dl, 'a'
		 int 21h
		  mov dl, 'c'
		 int 21h
		  mov dl, 'e'
		 int 21h
		  mov dl, 'b'
		 int 21h
		   mov dl, 'b'
		 int 21h
		  mov dl, 'a'
		 int 21h
		   mov dl, 'r'
		 int 21h
		   mov dl, ' '
		 int 21h
		   mov dl, 't'
		 int 21h
		 mov dl, 'o'
		 int 21h
		 mov dl, ' '
		 int 21h
		 mov dl, 'd'
		 int 21h
		 mov dl, 'o'
		 int 21h
		 mov dl, ' '
		 int 21h
		 mov dl, 'y'
		 int 21h
		 mov dl, 'o'
		 int 21h
		 mov dl, 'u'
		 int 21h
		 mov dl, 'r'
		 int 21h
		 mov dl, ' '
		 int 21h
		 mov dl, 't'
		 int 21h
		 mov dl, 'u'
		 int 21h
		 mov dl, 'r'
		 int 21h
		 mov dl, 'n'
		 int 21h
		 mov dh, 5 ; row
	     mov dl, 45 ; col
		 int 10h
	     mov dl, 'E'
		 int 21h
		 mov dl, 's'
		 int 21h
		 mov dl, 'c'
		 int 21h
		 mov dl, ' '
		 int 21h
		 mov dl, '='
		 int 21h
		 mov dl, ' '
		 int 21h
		 mov dl, 'g'
		 int 21h
		 mov dl, 'e'
		 int 21h
		  mov dl, 't'
		 int 21h
		  mov dl, 's'
		 int 21h
		  mov dl, ' '
		 int 21h
		  mov dl, 'o'
		 int 21h
		   mov dl, 'u'
		 int 21h
		  mov dl, 't'
		 int 21h
	Orange:	
			mov player1, 1
			mov player2, 11
			call	Marking
			call	UpdateBoard  
			call	PlaceCursor
			call	CursorMovement		
			cmp al, 27 
			jnz Movit
			jmp Win
	Movit:
			call	Movement
			mov cl, eating
			sub pinkc, cl
			mov cl, eating1
			add orangec, cl
			cmp pinkc, 0 
			jnz o1
			jmp Win
	o1:		mov eating, 0
			mov eating1, 0
			mov cl, player2
			mov ch, player1

	CheckWin1:
			mov al, pinkc
			add al, orangec
			cmp al, 100
			jz Win
	Pink:	mov player1, 11
			mov player2, 1
			call	Marking
			call	UpdateBoard  
			call	PlaceCursor
			call	CursorMovement
			cmp al, 27 
			jnz Movit1
			jmp Win
	Movit1:
			call	Movement
			mov cl, eating1
			add pinkc, cl
			mov cl, eating
			sub orangec, cl
			cmp orangec, 0 
			jnz p1
			jmp Win
	p1:		mov eating, 0
			mov eating1, 0
			mov cl, player1
			mov ch, player2
	CheckWin2:
			mov al, pinkc
			add al, orangec
			mov ah, 100
			cmp al, ah
			jz Win
			jmp Orange
	Win:	mov ah, pinkc
			mov al, orangec
			cmp ah, al
	        jnz Win2 
			jmp Tie
	Win2:
			cmp ah, al
			jg PinkWins
	OrangeWins:
		 mov bl, ah
		 mov ah, 2
		 mov dh, 4 ; row
	     mov dl, 4 ; col
		 int 10h
	     mov dl, 'T'
		 int 21h  
		 mov dl, 'h'
		 int 21h 
		 mov dl, 'e'
		 int 21h
		 mov dl, ' '
		 int 21h
		 mov dl, 'o'
		 int 21h
		 mov dl, 'r'
		 int 21h
		 mov dl, 'a'
		 int 21h
		 mov dl, 'n'
		 int 21h
		 mov dl, 'g'
		 int 21h
		 mov dl, 'e'
		 int 21h
		 mov dl, ' '
		 int 21h
		 mov dl, 'w'
		 int 21h
		 mov dl, 'o'
		 int 21h
		 mov dl, 'n'
		 int 21h
		 mov dl, '!'
		 int 21h
	     mov ah, 7
		 int 21h
		 jmp TheEn
	PinkWins:	
		 mov bl, al	
		 mov ah, 2
		 mov dh, 4 ; row
	     mov dl, 4 ; col
		 int 10h
	     mov dl, 'T'
		 int 21h  
		 mov dl, 'h'
		 int 21h 
		 mov dl, 'e'
		 int 21h
		 mov dl, ' '
		 int 21h
		 mov dl, 'p'
		 int 21h
		 mov dl, 'i'
		 int 21h
		 mov dl, 'n'
		 int 21h
		 mov dl, 'k'
		 int 21h
		 mov dl, ' '
		 int 21h
		 mov dl, 'w'
		 int 21h
		 mov dl, 'o'
		 int 21h
		 mov dl, 'n'
		 int 21h
		 mov dl, '!'
		 int 21h
		 mov ah, 7
	     int 21h
		 jmp TheEn
	Tie:	
		 mov bl, ah
		 mov ah, 2
		 mov dh, 4 ; row
	     mov dl, 4 ; col
		 int 10h
	     mov dl, 'I'
		 int 21h  
		 mov dl, 't'
		 int 21h 
		 mov dl, ' '
		 int 21h
		 mov dl, 'i'
		 int 21h
		 mov dl, 's'
		 int 21h
		 mov dl, ' '
		 int 21h
		 mov dl, 'a'
		 int 21h
		 mov dl, ' '
		 int 21h
		 mov dl, 't'
		 int 21h
		 mov dl, 'i'
		 int 21h
		 mov dl, 'e'
		 int 21h
		 mov dl, '!'
		 int 21h
		 mov ah, 7
	     int 21h
	TheEn:
			


			int 3

cseg	ends
end		Start