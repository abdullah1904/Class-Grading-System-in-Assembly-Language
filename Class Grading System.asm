include emu8086.inc
org 100h
.data 
    numberOfStudents DW 0                                                             
	marksArray DB 50 DUP (?)           
	idArray DB 50 DUP (?)
	gradeArray DB 50 DUP (?)
    marks DB 0
	MSG1 DB 'Enter the number of students(DOES NOT EXCEED 50): ','$'                                 
	MSG2 DB 0Dh,0Ah, 0Dh,0Ah,'Enter the IDs of students: ','$'                     
	MSG3 DB 0Dh,0Ah, 0Dh,0Ah,'Enter the marks of students: ','$'
	MSG4 DB 0Dh,0Ah, 0Dh,0Ah,'ID: ',09H,'MARKS:',09H,'GRADE:','$'                                
	HR DB 0Dh,0Ah, 0Dh,0Ah,'*******************Class Result***********************','$'    

.code
main proc
    mov ax, @data
    mov ds,ax
    mov dx,offset MSG1
    mov ah,9
    int 21h 
    call scan_num
    mov numberOfStudents,cx 
    
    MOV SI, 0
    LOOP1:  
            mov dx, offset MSG2	
            mov ah,9
            int 21h
            CALL SCAN_NUM 
        	MOV idArray[SI],CL
            mov dx, offset MSG3
            mov ah,9
            int 21h
            call scan_num
            mov marksArray[SI],CL
        	INC SI  
        	PRINT 0AH        
        	PRINT 0DH         
        	CMP SI,numberOfStudents 
        	JNE LOOP1
    MOV DX, offset HR
    MOV AH,9
    INT 21h
    MOV DX, offset MSG4
    MOV AH,9
    INT 21h 
    PRINT 0AH 
    PRINT 0DH  	
    MOV SI, 0
    LOOP3:  	
            MOV AX,0
        	MOV AL,idArray[SI]     
        	CALL PRINT_NUM_UNS    
        	PRINT 09H            
        	MOV AL,marksArray[SI]
        	CALL PRINT_NUM_UNS 
        	PRINT 09H
            MOV marks,AL 
            
            cmp marks,100
            jg error
            cmp marks,80
            jge first 
            cmp marks,70
            jge second 
            cmp marks,60
            jge third
            cmp marks,50
            jge fourth
            cmp marks,0
            jge fail
            cmp marks,0
            jl error
            
            
            first:
                print 'A'
                jmp thread  
            second:
                print 'B'
                jmp thread
            third:
                print 'C'
                jmp thread    
            fourth:
                print 'E'
                jmp thread
            fail:
                print 'F'
                jmp thread 
            error:
                print 'Invalid Marks' 
                jmp thread
            thread:
        	PRINT 0AH             
        	PRINT 0DH            
        	INC SI 
        	CMP SI,numberOfStudents 
        	JNE LOOP3
    
    
     
DEFINE_SCAN_NUM            
DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS
end mainp
main end