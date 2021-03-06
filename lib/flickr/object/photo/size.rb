module Flickr
  class Object
    class Photo

      ##
      # Encapsulates the logic of managing sizes, including comparison,
      # to make it easier to add dynamic size-changing methods to
      # Flickr::Object::Photo.
      #
      # @private
      #
      class Size

        include Comparable

        NAMES = Photo::SIZES

        ##
        # Used by Flickr for hash key names.
        #
        ABBREVIATIONS = %w[sq t q s n m z c l h k o]

        ##
        # Used by Flickr in response from "flickr.photos.getSizes".
        #
        LABELS = [
          "Square", "Thumbnail", "Large Square",
          "Small", "Small 320",
          "Medium", "Medium 640", "Medium 800",
          "Large", "Large 1600", "Large 2048",
          "Original",
        ]

        def self.all
          NAMES.map { |name| new(name) }
        end

        def self.types
          all.map(&:type).uniq
        end

        def self.exists?(name)
          all.include? new(name)
        end

        attr_reader :name, :type, :number, :abbreviation, :label

        def initialize(name)
          @name          = name
          @type, @number = name.split
          @abbreviation  = ABBREVIATIONS[NAMES.index(name)]
          @label         = LABELS[NAMES.index(name)]
        end

        ##
        # {NAMES} orders the sizes from smallest to largest, so we're
        # using that here.
        #
        def <=>(other)
          NAMES.index(self.name) <=> NAMES.index(other.name)
        end

      end

    end
  end
end
