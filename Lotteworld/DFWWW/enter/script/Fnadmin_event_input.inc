<%
Dim intCurPage  '���� ������
Dim intPage   '�ӽ� ���� ������
Dim intLastPage '���� ������
Dim intLimit '������ �� ����
Dim IntStartPage '���� ������
Dim dtToday '���ó�¥
Dim intPos '������ ��ġ
Dim intTotalPage '�� ������

function FnDateFormat(df) '���Ⱓ ��¥ ǥ�� ���� (00/00/00)
df=cstr(df)
df=replace(df,"-","/")
df=right(df,8)
FnDateFormat=df
end function

dtToday=date()
function FnDateInter(di,di2)  'today, month �����Լ�
IF dtToday >= di and dtToday <= di2 THEN '��� �Ⱓ�� ������ ���Ե� ���
 FnDateInter =1
ELSEIF not(dtToday>= di and dtToday<=di2) THEN '���Ե����� ������ �̹� ���� ���Ե� ���
 IF year(dtToday)=year(di) and month(dtToday)=month(di) or year(dtToday)=year(di2) and month(dtToday)=month(di2) THEN
  FnDateInter= 2
 END IF
ELSE
FnDateInter=3
END IF
end function

IF intPAGE="" THEN '������ ��� (�Խ��� ����) �� ���� �ڵ�
intCurPAGE=1
ELSE
intCurPAGE=intPAGE
END IF
rs.PAGESize = 5 '�� �������� �ѷ��� ��� ��
intTotalPage=rs.PAGESize 
intLastPage=rs.PAGEcount
IF not rs.EOF THEN
rs.AbsolutePage = intCurPage
END IF

intLimit=10 ' ���� - ���� ���̿� �� ������ ��
intPos=(intCurPage-1) mod intLimit
intStartPage=intCurPage-intPos 
%>