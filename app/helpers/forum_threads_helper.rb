# frozen_string_literal: true

module ForumThreadsHelper
  def calcular_popularidad(forum_thread)
    rep = 0
    forum_thread.forum_posts.each do |forum_post|
      rep += forum_post.get_likes.size
      rep -= forum_post.get_dislikes.size
      forum_post.comments.each do |comment|
        rep += comment.get_likes.size
        rep -= comment.get_dislikes.size
      end
    end
    rep
  end

  def mas_populares
    valores = []
    populares = {}
    ForumThread.all.each do |forum_thread|
      valores += [calcular_popularidad(forum_thread)]
    end
    valores.sort! { |x, y| y <=> x }
    valores = valores[0, 5]
    valores.each do |valor|
      ForumThread.all.each do |forum_thread|
        if  valor.eql? calcular_popularidad(forum_thread)
          populares[forum_thread] = calcular_popularidad(forum_thread)
        end
      end
    end
    populares
  end
end
