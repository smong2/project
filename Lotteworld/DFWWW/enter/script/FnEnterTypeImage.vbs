<script language=vbscript runat=server>
FUNCTION FnChangeImage(varEnterType,day) '실입장,매표입장 이미지 교환
IF varEnterType="vxt" THEN
FnChangeImage="title_ticket_" & day & ".gif"
ELSE
FnChangeImage="title_true_" & day & ".gif"
END IF
end function
</script>