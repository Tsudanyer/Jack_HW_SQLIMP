--�{���}�l
  create procedure gen_seats ( @v_ptime  varchar(20), 
                               @v_movie  int, 
                               @v_roomid varchar(10) )
  AS
  BEGIN
    DECLARE   @v_row     int;
    DECLARE   @v_col     int;
    DECLARE   @x_row     int;
    DECLARE   @x_col     int;
  
      --���d�M ���w�U�|���y��� row, col
      select @v_row = seat_row , @v_col = seat_col
      from   m_room
      where  roomid=@v_roomid

      --�ھڮy��� @v_row, @v_col ���ͮy���
       SET @x_row = 1;       
       WHILE ( @x_row  <= @v_row )
         BEGIN
           SET @x_col = 1;     
           WHILE ( @x_col  <= @v_col )
             BEGIN
               insert into seats values ( @v_ptime, @v_movie, RIGHT(REPLICATE('0', 1)+CAST(@x_row as NVARCHAR), 2)+'-'+RIGHT(REPLICATE('0', 1)+CAST(@x_col as NVARCHAR), 2), '0', NULL);
               SET @x_col =@x_col+1;  --�W�[ @x_col
             END;
           SET @x_row =@x_row+1 -- �]�w @x_row, @x_col
         END;
   END;
    
--�{������