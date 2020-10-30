<?php
class CommonController extends Podo_Controller_Base
{
	public function doPageNavigator() /*{{{*/
	{
		$maxPage   = isset($this->request->max) ? $this->request->max : 1;
		$currPage  = isset($this->request->curr) ? $this->request->curr : 1;
		$pageBlock = isset($this->request->block) ? $this->request->block : 10;
		$callback  = isset($this->request->callback) ? $this->request->callback : null;

		if ($currPage < 1) {
			$currPage = 1;
		}

		if ($currPage > $maxPage) {
			$currPage = $maxPage;
		}

		$firstPage        = (int)(($currPage-1)/$pageBlock) * $pageBlock + 1;
		$lastPage         = min(((int)(($currPage-1)/$pageBlock)+1)*$pageBlock, $maxPage);
		$prevPage         = max($firstPage-1, 1);
		$nextPage         = min($lastPage+1, $maxPage);
		$dblPrevPage      = 1;
		$dblNextPage      = $maxPage;
		$isShowPrevBtn    = (bool)($firstPage > 1);
		$isShowNextBtn    = (bool)($lastPage < $maxPage);
		$isShowDblPrevBtn = $isShowPrevBtn;
		$isShowDblNextBtn = $isShowNextBtn;

		$this->response->currPage         = $currPage;
		$this->response->firstPage        = $firstPage;
		$this->response->lastPage         = $lastPage;
		$this->response->prevPage         = $prevPage;
		$this->response->nextPage         = $nextPage;
		$this->response->dblPrevPage      = $dblPrevPage;
		$this->response->dblNextPage      = $dblNextPage;
		$this->response->isShowPrevBtn    = $isShowPrevBtn;
		$this->response->isShowNextBtn    = $isShowNextBtn;
		$this->response->isShowDblPrevBtn = $isShowDblPrevBtn;
		$this->response->isShowDblNextBtn = $isShowDblNextBtn;
		$this->response->callback         = $callback;
	} /*}}}*/
}
?>
