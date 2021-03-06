class RegenerateStatService
  class << self
    def anime_genre_breakdown
      user_stat(:anime, 'Stat::AnimeGenreBreakdown')
    end

    def manga_genre_breakdown
      user_stat(:manga, 'Stat::MangaGenreBreakdown')
    end

    def anime_amount_consumed
      user_stat(:anime, 'Stat::AnimeAmountConsumed')
    end

    def manga_amount_consumed
      user_stat(:manga, 'Stat::MangaAmountConsumed')
    end

    private

    def user_stat(media_column, stat_type)
      User.where(id: LibraryEntry.select(:user_id).by_kind(media_column))
          .find_each do |user|
            user.stats.find_by(type: stat_type).recalculate!
          end
    end
  end
end
