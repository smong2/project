<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0">
	<channel>
		<title>기억나 MP 목록</title>
		<link>http://memory.nate.com/admin/mp/index</link>
		<description>MP 목록에 등록된 글을 카테고리 별로 구독합니다.</description>
		<language>ko</language>

		<pubDate>Wed, 29 Jul 2009 16:27:14 +0900</pubDate>
		<generator>Nate.com(http://www.nate.com)</generator>
		<docs>http://memory.nate.com/admin/mp/index</docs>
		<image>
			<title>기억나 MP 목록 새글</title>
			<url></url>
			<link>http://memory.nate.com/admin/mp/index</link>
			<description>기억나 MP 목록에 동록된 글을 카테고리 별로 구독합니다.</description>
		</image>

		<item podo:foreach="$this->mps as $mp" class="{%ISLAST% ? 'last' : ''}">
			<title>{$mp->getMpNm()}</title>
			<link>#{$mp->getMpSq()}</link>
			<description>{$mp->getMpNm()}</description>
			<author>{$mp->getCreatorNick()}</author>
			<category>{$mp->getCategory()->getCategoryNm()}</category>
			
			<guid>{$mp->getMpSq()}</guid>
			<comments>#{$mp->getMpSq()}</comments>
			<pubDate>{date('r', $mp->getInsertDt())}</pubDate>
		</item>	
		</channel>
</rss>