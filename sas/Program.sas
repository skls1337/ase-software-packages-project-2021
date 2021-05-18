DATA WORK.FESTIVALSALESEXPANDED_0000;
    LENGTH
        Date               8
        'Festival Name'n $ 16
        'Tickets sold'n    8
        'Ticket Price'n    8
        'Revenue Earned (euro)'n   8 ;
    FORMAT
        Date             DATE9.
        'Festival Name'n $CHAR16.
        'Tickets sold'n  BEST12.
        'Ticket Price'n  BEST12.
        'Revenue Earned (euro)'n BEST12. ;
    INFORMAT
        Date             DATE9.
        'Festival Name'n $CHAR16.
        'Tickets sold'n  BEST12.
        'Ticket Price'n  BEST12.
        'Revenue Earned (euro)'n BEST12. ;
    INFILE '/saswork/SAS_work5B6E0000C9B3_odaws02-euw1.oda.sas.com/#LN00016'
        LRECL=40
        ENCODING="UTF-8"
        TERMSTR=CRLF
        DLM='7F'x
        MISSOVER
        DSD ;
    INPUT
        Date             : BEST32.
        'Festival Name'n : $CHAR16.
        'Tickets sold'n  : BEST32.
        'Ticket Price'n  : BEST32.
        'Revenue Earned (euro)'n : BEST32. ;
RUN;