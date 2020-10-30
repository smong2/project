<a href="?page={$this->dblPrevPage}" class="go-first" title="처음페이지로 이동" podo:if="$this->isShowDblPrevBtn" onclick="try { {$this->callback}({$this->dblPrevPage}); return false; } catch (e) { }" attr-if:onclick="isset($this->callback)">처음페이지</a>
<a href="?page={$this->prevPage}" class="go-previous" title="이전페이지로 이동" podo:if="$this->isShowPrevBtn" onclick="try { {$this->callback}({$this->prevPage}); return false; } catch (e) { }" attr-if:onclick="isset($this->callback)">이전페이지</a>
<span class="bar"></span>

<dummy podo:for="$i=$this->firstPage; $i<=$this->lastPage; $i++">
<a href="?page={$i}" class="page-num" title="{$i}페이지" podo:cond="$i != $this->currPage" onclick="try { {$this->callback}({$i}); return false; } catch (e) { }" attr-if:onclick="isset($this->callback)"><strong podo:cond="$i == $this->currPage" class="this">{$i}</strong></a>
<span class="bar"></span>
</dummy>

<a href="?page={$this->nextPage}" class="go-forward" title="다음페이지로 이동" podo:if="$this->isShowNextBtn" onclick="try { {$this->callback}({$this->nextPage}); return false; } catch (e) { }" attr-if:onclick="isset($this->callback)">다음페이지</a>
<a href="?page={$this->dblNextPage}" class="go-end" title="마지막페이지로 이동"  podo:if="$this->isShowDblNextBtn" onclick="try { {$this->callback}({$this->dblNextPage}); return false; } catch (e) { }" attr-if:onclick="isset($this->callback)">마지막페이지</a>
