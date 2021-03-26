require "../../../spec/support/factories/**"

# Add sample data helpful for development, e.g. (fake users, blog posts, etc.)
#
# Use `Db::Seed::RequiredData` if you need to create data *required* for your
# app to work.
class Db::Seed::SampleData < LuckyCli::Task
  summary "Add sample database records helpful for development"

  def call
    months = 24
    content = "<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Quisque sagittis purus sit amet volutpat. Interdum posuere lorem ipsum dolor. Diam maecenas sed enim ut sem viverra. Dignissim suspendisse in est ante in. Elit sed vulputate mi sit amet mauris. Posuere urna nec tincidunt praesent semper. Mattis vulputate enim nulla aliquet. Viverra orci sagittis eu volutpat odio facilisis. Aliquam vestibulum morbi blandit cursus. Quis varius quam quisque id diam vel. Facilisi cras fermentum odio eu feugiat pretium nibh ipsum consequat. Elementum tempus egestas sed sed risus pretium quam vulputate. Facilisis volutpat est velit egestas dui id ornare. Nec feugiat in fermentum posuere urna nec tincidunt praesent semper.</p>"
    
    (0..months).each do |month|
      pages = Random.new.rand(5)
      (0..pages).each do |page|
        days = Random.new.rand(27)
        SavePage.create!(
          name: "Generated Page #{UUID.random}",
          content: content,
          timestamp: (Time.utc - month.months).at_beginning_of_month + days.days
        )
      end
    end

    puts "Done adding sample data"
  end
end
