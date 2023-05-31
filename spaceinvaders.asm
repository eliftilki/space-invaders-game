#make_COM#

; COM file is loaded at CS:0100h
ORG 100h
;ELİF TİLKİ SPACE İNVADERS OYUNU
gemiyiharaketettir macro
    mov cx,1
    mov bp,offset veri
    mov ah,13h
    mov al,1
    mov bh,0
    mov bl,0111b
    mov dh,20
    mov dl,[sutun1]
    int 10h
gemiyiharaketettir endm

gemiyigüncelle macro
    mov cx,1
    mov bp,offset veri3
    mov ah,13h
    mov al,1
    mov bh,0
    mov bl,0111b
    mov dh,20
    mov dl,[sutun1]
    int 10h
gemiyigüncelle endm        

uzayliyazdir macro
    mov ah,13h
    mov al,1
    mov bh,0
    mov bl,1010b
    mov dh,4
    int 10h
uzayliyazir endm

newuzayli macro
    mov cx,1    
    uzayliyazdir
newuzayli endm  

uzaylisilmacro macro
    mov cx,1
    mov bp,offset veri3
    mov ah,13h
    mov al,1
    mov bh,0
    mov bl,0111b
    mov dh,4
    int 10h
uzaylisilmacro endm    

mov al,03h
mov ah,00h
int 10h

    mov cx,5
    mov bp,offset girişyazısı
    mov ah,13h
    mov al,1
    mov bh,0
    mov bl,1100b
    mov dh,5
    mov dl,37
    int 10h
    
    mov cx,8
    mov bp,offset girişyazısı1
    mov ah,13h
    mov al,1
    mov bh,0
    mov bl,1010b
    mov dh,6
    mov dl,36
    int 10h
    
    mov cx,62
    mov bp,offset girişyazısı2
    mov ah,13h
    mov al,1
    mov bh,0
    mov bl,1111b
    mov dh,14
    mov dl,10
    int 10h
    
    mov cx,34
    mov bp,offset girişyazısı3
    mov ah,13h
    mov al,1
    mov bh,0
    mov bl,1111b
    mov dh,16
    mov dl,10
    int 10h
    
    MOV AH, 00H  
    INT 16H
    
    cmp al," "
    je girişsilme
    
    girişsilme:
    
    mov cx,5
    mov bp,offset girişyazısı4
    mov ah,13h
    mov al,1
    mov bh,0
    mov bl,0111b
    mov dh,5
    mov dl,37
    int 10h
    
    mov cx,8
    mov bp,offset girişyazısı4
    mov ah,13h
    mov al,1
    mov bh,0
    mov bl,0111b
    mov dh,6
    mov dl,36
    int 10h
    
    mov cx,62
    mov bp,offset girişyazısı4
    mov ah,13h
    mov al,1
    mov bh,0
    mov bl,0111b
    mov dh,14
    mov dl,10
    int 10h
    
    mov cx,34
    mov bp,offset girişyazısı4
    mov ah,13h
    mov al,1
    mov bh,0
    mov bl,0111b
    mov dh,16
    mov dl,10
    int 10h

gameloop:  
    gemiyiharaketettir ;gemiyi ekrana yazdırır
    
    mov bp,offset veri2  ;uzaylıyı ekrana yazdırı
    mov dl,[sutun2]
    newuzayli

    mov bp,offset veri6
    mov dl,[veriy6]
    newuzayli

    mov bp,offset veri7
    mov dl,[veriy7]
    newuzayli

    mov bp,offset veri8
    mov dl,[veriy8]
    newuzayli

    mov bp,offset veri9
    mov dl,[veriy9]
    newuzayli

    mov bp,offset veri10
    mov dl,[veriy10]
    newuzayli

    mov bp,offset veri11
    mov dl,[veriy11]
    newuzayli

    mov bp,offset veri12
    mov dl,[veriy12]
    newuzayli
    
    MOV AH, 00H  ;klavyeden girdi girilmesini sağlar
    INT 16H

    cmp al,"a"   ;girdinin a olup olmadığını sorgular
    je moveleft

    cmp al,"d"
    je moveright

    cmp al," "
    je ateş

    moveleft:
        gemiyigüncelle   ;eski konumdaki gemiyi siler 
        dec word ptr [sutun1] ; sola gitmek için sutun değerini azaltır
        jmp gameloop
    
    moveright:
        gemiyigüncelle 
        inc word ptr [sutun1] 
        jmp gameloop
    
    ateş:
        mov bh,[sutun1]  ;geminin sutun konumunu alır
        mov byte ptr [weaponx], bh 
        mov byte ptr [weapony], 19 ; mermiyi geminin satır değerinden bir üste koyar
        jmp weapongüncelle 
   
    weapongüncelle:
        mov cx,1   ;ekrana mermiyi yazdırır
        mov bp,offset veri4
        mov ah,13h
        mov al,1
        mov bh,0
        mov bl,1110b
        mov dh,[weapony]
        mov dl,[weaponx]
        int 10h
        
        mov cx,5  ;merminin uzaylıyı vurması için gideceği yol 5 kez tekrar eder
        haraketettir:
            push cx
            mov cx,1  ; önce eski konumdaki mermiyi siler
            mov bp,offset veri3
            mov ah,13h
            mov al,1
            mov bh,0
            mov bl,0111b
            mov dh,[weapony]
            mov dl,[weaponx]
            int 10h
            dec word ptr [weaponY]
            dec word ptr [weaponY]
            dec word ptr [weaponY]
            mov cx,1  ;yeni konumdaki mermiyi ekrana çizer
            mov bp,offset veri4
            mov ah,13h
            mov al,1
            mov bh,0
            mov bl,1110b
            mov dh,[weapony]
            mov dl,[weaponx]
            int 10h
            pop cx    
        loop haraketettir
        
        mov cx,1  ;merminin son bulduğu konumu siler
        mov bp,offset veri3
        mov ah,13h
        mov al,1
        mov bh,0
        mov bl,0111b
        mov dh,[weapony]
        mov dl,[weaponx]
        int 10h     
        jmp uzayligüncelle
        
    uzayligüncelle:
        mov bl,[sutun2]  ; merminin son bulduğu yerde uzaylı olup olmadığını kontrol eder
        cmp [weaponx],bl
        je uzaylisil1
        
        mov bl,[veriy6]
        cmp [weaponx],bl
        je uzaylisil2
        
        mov bl,[veriy7]
        cmp [weaponx],bl
        je uzaylisil3
        
        mov bl,[veriy8]
        cmp [weaponx],bl
        je uzaylisil4
        
        mov bl,[veriy9]
        cmp [weaponx],bl
        je uzaylisil5
        
        mov bl,[veriy10]
        cmp [weaponx],bl
        je uzaylisil6
        
        mov bl,[veriy11]
        cmp [weaponx],bl
        je uzaylisil7
        
        mov bl,[veriy12]
        cmp [weaponx],bl
        je uzaylisil8
        
        jmp uzaylidevam
                
        uzaylisil1:       ; eğer uzaylı varsa veriyi boşlukla değiştirir
            mov veri2," "
            dec veri13
            jmp uzaylidevam
        
        uzaylisil2: 
            mov veri6," "
            dec veri13
            jmp uzaylidevam
        
        uzaylisil3: 
            mov veri7," "
            dec veri13
            jmp uzaylidevam
        
        uzaylisil4: 
            mov veri8," "
            dec veri13
            jmp uzaylidevam
        
        uzaylisil5: 
            mov veri9," "
            dec veri13
            jmp uzaylidevam
        
        uzaylisil6: 
            mov veri10," "
            dec veri13
            jmp uzaylidevam
        
        uzaylisil7: 
            mov veri11," "
            dec veri13
            jmp uzaylidevam
        
        uzaylisil8: 
            mov veri12," "
            dec veri13
            jmp uzaylidevam
         
    uzaylidevam:
        mov dl,[sutun2] ; eski konumdaki uzaylıları siler
        uzaylisilmacro
        
        mov dl,[veriy6]
        uzaylisilmacro
        
        mov dl,[veriy7]
        uzaylisilmacro
        
        mov dl,[veriy8]
        uzaylisilmacro
        
        mov dl,[veriy9]
        uzaylisilmacro
           
        mov dl,[veriy10]
        uzaylisilmacro
        
        mov dl,[veriy11]
        uzaylisilmacro
        
        mov dl,[veriy12]
        uzaylisilmacro
        
        mov bx, offset veri13
        mov al,[bx]
        
        cmp al,0h
        je gameexit
        
        cmp al,0h
        jne gamedevam
        
        gameexit:
            mov veri," "
            gemiyiharaketettir
            jmp exit
            
        gamedevam:    
           
        mov bx, offset veri5  ; veri5 teki değeri al ye atar
        mov al,[bx]
  
        cmp al,0h  ;al 0 dan büyük oldukça çalışır
        jg solakaydır
        
        
        cmp al,0h  ;al 0 dan küçük oldukça çalışır
        jl sagakaydır
        
        jmp gameloop
        
        solakaydır:
            dec veri5  ;veri5 i azaltır
            mov bx, offset veri5
            mov al,[bx]
            dec sutun2 ;uzaylıların yeni konum bilgileri ayarlanır
            dec veriy6
            dec veriy7
            dec veriy8
            dec veriy9
            dec veriy10
            dec veriy11
            dec veriy12
            
            cmp al,0h  
            je azaltmaveri5 ;al 0 a eşitse çalışır
            
            cmp al,0h
            jne soldevam
        
            azaltmaveri5:
                sub veri5,13  ;veri5 13 azaltılırr
                jmp gameloop
            
            soldevam:
            jmp gameloop  
            
        sagakaydır:
            inc veri5 ; veri5 i arttırır
            mov bx, offset veri5
            mov al,[bx]
            inc sutun2 ;uzaylıların yeni konum bilgileri ayarlanır
            inc veriy6
            inc veriy7
            inc veriy8
            inc veriy9
            inc veriy10
            inc veriy11
            inc veriy12
            
            cmp al,0h
            je arttırmaveri5 ;al 0 a eşitse çalışır
            
            cmp al,0h
            jne sagdevam
            
            arttırmaveri5:
                add veri5,13  ;veri5 13 arttırılır
                jmp gameloop
                
            sagdevam:
            jmp gameloop
            
                
exit:
    mov cx,4
    mov bp,offset çıkışyazısı3
    mov ah,13h
    mov al,1
    mov bh,0
    mov bl,1011b
    mov dh,10
    mov dl,31
    int 10h
    
    mov cx,10
    mov bp,offset çıkışyazısı
    mov ah,13h
    mov al,1
    mov bh,0
    mov bl,1110b
    mov dh,10
    mov dl,35
    int 10h
    
    mov cx,4
    mov bp,offset çıkışyazısı3
    mov ah,13h
    mov al,1
    mov bh,0
    mov bl,1011b
    mov dh,10
    mov dl,45
    int 10h
    
    mov cx,42
    mov bp,offset çıkışyazısı2
    mov ah,13h
    mov al,1
    mov bh,0
    mov bl,1111b
    mov dh,16
    mov dl,19
    int 10h
                                           
mov ah,4ch
int 21h

ret

veri db 'X'
sutun1 db 39

veri2 db 'W'
sutun2 db 10

veri6 db "W"
veriy6 db 17

veri7 db "W"
veriy7 db 24

veri8 db "W"
veriy8 db 31

veri9 db "W"
veriy9 db 38

veri10 db "W"
veriy10 db 45

veri11 db "W"
veriy11 db 52

veri12 db "W"
veriy12 db 59

veri3 db " "

veri4 db "*"
weaponx db 0
weapony db 0

veri5 db 5

veri13 db 8

girişyazısı db "SPACE"
girişyazısı1 db "INVADERS"
girişyazısı2 db "Kurallar: a ile sol, d ile sağ giderek uzaylıları vuracaksınız"
girişyazısı3 db "Başlamak için SPACE tuşuna basınız"
girişyazısı4 db "                                                                "

çıkışyazısı db "KAZANDINIZ"
çıkışyazısı2 db "Tüm uzaylıları vurup 800 score kazandınız!"
çıkışyazısı3 db "****"


