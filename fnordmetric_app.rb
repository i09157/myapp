#encoding: utf-8
require "fnordmetric"

FnordMetric.namespace :myapp do
  hide_active_users
  toplist_gauge :popular_articles, title: "閲覧数の多い質問"
  toplist_gauge :update_articles,title: "新着・更新質問"
  toplist_gauge :popular_users, :title => "人気ユーザ",
    :resolution => 2.minutes
  toplist_gauge :popular_keywords,
    :title => "人気キーワード",
    :resolution => 2.minutes
  gauge :article_views_per_second, tick: 1.second
  widget "ArticleViews",
    title: "Views per Second",
    type: :timeline,
    width: 100,
    gauges: :article_views_per_second,
    include_current: true,
    autoupdate: 1

  event :view_article do
    observe :popular_articles, data[:title]
    incr :article_views_per_second
  end
  event :update_article do
    observe :update_articles, data[:title]
  end
   event :search do
    observe :popular_keywords, data[:keyword]
  end
end

FnordMetric::Web.new(port: 4242)
FnordMetric::Worker.new
FnordMetric.run