# Hugo Multilingual Blog Setup

This Hugo blog now supports English (en) and Chinese (zh) languages with the following features:

## Structure

### Content Organization
```
content/
├── en/                    # English content
│   ├── posts/            # English blog posts
│   ├── search.md         # English search page
│   ├── archives.md       # English archives page
│   └── _index.md         # English home page
└── zh/                    # Chinese content
    ├── posts/            # Chinese blog posts
    ├── search.md         # Chinese search page
    ├── archives.md       # Chinese archives page
    └── _index.md         # Chinese home page
```

### URL Structure
- English posts: `/en/posts/post-title/`
- Chinese posts: `/zh/posts/post-title/`
- English home: `/en/`
- Chinese home: `/zh/`

## Features

### Language Switcher
- Visible in the header with language names (English/中文)
- Uses localStorage to persist user's language preference
- Automatically redirects to preferred language on page load
- SEO-friendly with hreflang tags

### Navigation
- Language-specific menus with proper translations
- English: home, archives, categories, tags, search
- Chinese: 首页, 归档, 分类, 标签, 搜索

### Search Functionality
- Works across both languages
- Translated search placeholders
- Language-specific search results

### Configuration
- Default language: English
- Hugo multilingual mode enabled in `config.yml`
- PaperMod theme with custom header override

## Adding New Content

### English Posts
Create files in `content/en/posts/` with standard Hugo front matter.

### Chinese Posts
Create files in `content/zh/posts/` with Chinese content and translated front matter.

### Translations
For translated versions of the same post, you can use translation keys or create separate posts in each language directory.

## Build Command
```bash
hugo --minify
```

## Deployment
The site is built to `docs/` directory for GitHub Pages deployment.