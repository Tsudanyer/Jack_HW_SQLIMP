--�s�Wtrigger trig_seats 
create TRIGGER trig_seats 
ON    playlist
AFTER INSERT
AS
BEGIN
  DECLARE   @v_row     int;
  DECLARE   @v_col     int;
  DECLARE   @x_row     int;
  DECLARE   @x_col     int;
  DECLARE   @v_ptime   varchar(20); 
  DECLARE   @v_movie   int;
  DECLARE   @v_roomid  varchar(10);

  --���d�� ���w�U�|���y��� row, col
  --�ޥηs���ȱq inserted ��� ; �L�k�����H inserted.ptime�s��
   
  SELECT @v_ptime = ptime, @v_movie = movie, @v_roomid = roomid
  FROM   inserted;
      
  select @v_row = seat_row, @v_col = seat_col
  from   m_room
  where  @v_roomid = roomid

  --�ھڮy��� @v_row, @v_col ���ͮy���
  SET @x_row = 1;     

  WHILE ( @x_row  <= @v_row )
    BEGIN
      SET @x_col = 1;     
      WHILE ( @x_col  <= @v_col )
        BEGIN
          insert into seats values ( @v_ptime, @v_movie, 
								     RIGHT('0' + cast( @x_row as varchar(2)), 2) + '-' + 
									 RIGHT('0' + cast( @x_col as varchar(2)), 2), '0', NULL);
          SET @x_col = @x_col + 1		--�W�[ @x_col
        END;
      SET @x_row = @x_row + 1		--�W�[ @x_row
    END;
END;
    
--���տ�X���O
insert  into playlist values ('2008-12-25 13:00', 1, 'A�U') 

select * from seats where seat_num = '25-20'
