<script language=vbscript runat=server>
FUNCTION FnChangeImage(varEnterType,day) '������,��ǥ���� �̹��� ��ȯ
IF varEnterType="vxt" THEN
FnChangeImage="title_ticket_" & day & ".gif"
ELSE
FnChangeImage="title_true_" & day & ".gif"
END IF
end function
</script>