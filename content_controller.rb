class ClientApi::ContentController < ApiBaseController

	def homepage
        session = ShopifyAPI::Session.new(Shop.current_shopify_domain, Shop.current_shopify_token)
        ShopifyAPI::Base.activate_session(session)
        blogs = ShopifyAPI::Blog.all
        all_articles = blogs.flat_map(&:articles)
        articles = []
        all_articles.each do |article|
            if (article.tags=="home")
                articles<<{:title => article.title, :date=>article.created_at, :image => article.attributes['image'].present? ? article.image.src : '', :body_html=>article.body_html}
            end
        end

        if(articles.present?)
            response = {:status=> true, :data=> {:articles => articles}}
        else
            response = {:status=> false, :message =>"Articles are not present."}
        end 

        json_response(response)
    end

end