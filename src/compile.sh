#!/bin/bash

# This script compiles every markdown script in "articles/" and puts them in "../posts/".  Additionally,
# it compiles a central database called "posts.json" in "../". 

# Directories
PostsBase='../posts'
Index='../index.html'
ArticlesDir='articles'
HeaderFile='templates/header.html'
FooterFile='templates/footer.html'
IndexHeaderFile='templates/index_header.html'
IndexFooterFile='templates/index_footer.html'
IndexLinkFile='templates/index_link.html'

# Remove Pre-existing Index
rm -f $Index

# Copy the index header file to index
cp $IndexHeaderFile $Index

# Tools
MarkdownPl='perl ./scripts/Markdown.pl'
for Article in $ArticlesDir/*; do
	ArticleBase=$(basename -s .md $Article)
	ArticleDest=$PostsBase/$ArticleBase.html
	
	echo "Compiling article $ArticleBase"
	
	# Grep for the title, while skipping the TITLE: marker
	ArticleTitle=$(grep 'TITLE:' $Article)
	ArticleTitle=$(echo $ArticleTitle | cut -b 7-)
	
	# Stat the article for the last mod time, then convert it to a string using date
	ArticleLastModUnix=$(stat -c '%Y' $Article)
	ArticleLastMod=$(date -d @$ArticleLastModUnix +'%A, %B %d, %Y, at %T')
	ArticleLastMod2=$(date -d @$ArticleLastModUnix +'%Y-%m-%d at %T')
	
	# Print out the header while modifying the title and the last modification date.
	cat $HeaderFile | sed "s/XXX_TITLE_HERE_XXX/$ArticleTitle/g;s/XXX_LAST_MOD_DATE_XXX/$ArticleLastMod/g" > $ArticleDest
	
	# Remove the TITLE: from the markdown, and then convert it to html and concatenate it into ArticleDest
	grep -v 'TITLE:' $Article | $MarkdownPl >> $ArticleDest
	
	# Finally, concatenate the footer file into $ArticleDest.
	cat $FooterFile >> $ArticleDest
	
	# Add a link to the Index
	cat $IndexLinkFile | sed "s/XXX_TITLE_HERE_XXX/$ArticleTitle/g;s/XXX_LAST_MOD_DATE_2_XXX/$ArticleLastMod2/g;s/XXX_URL_HERE_XXX/posts\/$ArticleBase.html/g" >> $Index
done

## Add the footer
cat $IndexFooterFile >> $Index
