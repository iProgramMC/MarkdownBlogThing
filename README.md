# Markdown Blog Manager Thing

This tool allows you to create a simple markdown blog using a static web page platform such as
GitHub Pages.

## License

This project is licensed under the MIT License, except `src/scripts/Markdown.pl`, which is licensed
under the BSD 3-clause license.

## Workflow

- Step 1. Write your article. Save it in `src/articles/YYYY-MM-DD-short-name.md`.

- Step 2. Navigate to the `src/` directory, and call `./compile.sh`.

- Step 3. Deploy your newly created HTML (located in `posts`), to a platform such as GitHub Pages.

## How to get started

First, you will need to create a header, or a footer. A future version of this shell script may
allow you to use just one template.

Then, start creating articles!

Note: Each one will be recompiled. If that bothers you (e.g. you did a git reset or something),
simply avoid deploying those HTML files.  A future version of this shell script may allow you to
specify a date after which compilation is ignored.

## How it works

Here is an example of a markdown page:
```md
TITLE:Title goes Here

# TITLE

Hello there. I am some text.
```

Note the `TITLE:` part at the top. This is specifically filtered out before calling `Markdown.pl`.
This sets the title of the web page. Namely, it replaces `XXX_TITLE_HERE_XXX` within your header.

The header also has `XXX_LAST_MOD_DATE_XXX` replaced with the last modified date of the Markdown
file.

The header is concatenated into the generated HTML file, then the output of `Markdown.pl` on your
markdown file, then the footer.

## Dependencies

This project primarily depends on `perl`, `sed`, and `grep`. It also calls `cat`, `echo`, and
`basename`, though you probably already have those.
