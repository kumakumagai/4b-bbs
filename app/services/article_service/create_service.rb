module ArticleService
  class CreateService
    def create_categories!(params, article)
      category_ids = params[:article_categories][:category_id]

      category_ids.delete('')

      category_ids.map do |category_id|
        ArticleCategory.create!(article_id: article[:id], category_id: category_id)
      end
    end

    def create_tags!(params, article)
      tag_ids = params[:article_tags][:tag_id]

      tag_ids.delete('')

      tag_ids.map do |category_id|
        ArticleTag.create!(article_id: article[:id], tag_id: category_id)
      end
    end
  end
end