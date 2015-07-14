class GraphsController < ApplicationController
	
	protect_from_forgery
	
  def index
  	@region_names = []
	  @region_lowest = []
	  @region_average =[]
	  @region_highest = []
  	@regions = Region.all
	  @regions.each do |r| 
	  @region_names << r.name #adds each region name to an array to pass for next arg
		@region_lowest << r.prices.minimum(:cost).to_i
		@region_highest << r.prices.maximum(:cost).to_i
		@region_average << r.prices.average(:cost).to_i
	  end	
	
	
	@chart = LazyHighCharts::HighChart.new('graph') do |f|
	
      f.title({ :text=>"Combination chart"})
      f.options[:xAxis][:categories] = @region_names
	    f.labels(:items=>[:html=>"Total Data Points", :style=>{:left=>"40px", :top=>"8px", :color=>"black"} ])
      f.series(:type=> 'column',:name=> 'Lowest',:data=> @region_lowest)
      f.series(:type=> 'column',:name=> 'Average',:data=> @region_average)
      f.series(:type=> 'column', :name=> 'Highest',:data=> @region_highest)
      f.series(:type=> 'spline',:name=> 'Average', :data=> @region_average)
      f.series(:type=> 'pie',:name=> 'Total consumption', 
        :data=> [
          {:name=> 'Indica', :y=> 13, :color=> 'red'}, 
          {:name=> 'Sative', :y=> 23,:color=> 'green'},
          {:name=> 'Hybrid', :y=> 19,:color=> 'blue'}
        ],
        :center=> [100, 80], :size=> 100, :showInLegend=> false)
    end
	
    @states_chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title({ :text=>"State Pricing Data"})
	   	f.options[:xAxis][:categories] = @region_names
      f.series(:type=> 'column',:name=> 'Lowest',:data=> @region_lowest)
      f.series(:type=> 'column',:name=> 'Average',:data=> @region_average)
      f.series(:type=> 'column', :name=> 'Highest',:data=> @region_highest)
    end

    @chart2 = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(:text => "Population vs GDP For 5 Big Countries [2009]")
      f.xAxis(:categories => ["United States", "Japan", "China", "Germany", "France"])
      f.series(:name => "GDP in Billions", :yAxis => 0, :data => [14119, 5068, 4985, 3339, 2656])
      f.series(:name => "Population in Millions", :yAxis => 1, :data => [310, 127, 1340, 81, 65])
      f.yAxis [
        {:title => {:text => "GDP in Billions", :margin => 70} },
        {:title => {:text => "Population in Millions"}, :opposite => true},
      ]
      f.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical',)
      f.chart({:defaultSeriesType=>"column"})
    end

    @chart3 = LazyHighCharts::HighChart.new('pie') do |f|
          f.chart({:defaultSeriesType=>"pie" , :margin=> [50, 200, 60, 170]} )
          series = {
                   :type=> 'pie',
                   :name=> 'Browser share',
                   :data=> [
                      ['Firefox',   45.0],
                      ['IE',       26.8],
                      {
                         :name=> 'Chrome',    
                         :y=> 12.8,
                         :sliced=> true,
                         :selected=> true
                      },
                      ['Safari',    8.5],
                      ['Opera',     6.2],
                      ['Others',   0.7]
                   ]
          }
          f.series(series)
          f.options[:title][:text] = "THA PIE"
          f.legend(:layout=> 'vertical',:style=> {:left=> 'auto', :bottom=> 'auto',:right=> '50px',:top=> '100px'}) 
          f.plot_options(:pie=>{
            :allowPointSelect=>true, 
            :cursor=>"pointer" , 
            :dataLabels=>{
              :enabled=>true,
              :color=>"black",
              :style=>{
                :font=>"13px Trebuchet MS, Verdana, sans-serif"
              }
            }
          })
    end

		
		
	start_date = 12.months.ago.to_date
# => Wed, 16 Nov 2011

	end_date = Date.today
# => Sun, 16 Dec 2012

	number_of_months = (end_date.year*12+end_date.month)-(start_date.year*12+start_date.month)
# => 13
	@last_year_in_months = number_of_months.times.each_with_object([]) do |count, array|
	  array << [start_date.beginning_of_month + count.months,
	            start_date.end_of_month + count.months]
	end
	

  @months = []
	@months_avg = []
  @avg_month_prices = []
  @avg_day_prices = []
  
	@last_year_in_months.each do |m| 
		@months << Date::MONTHNAMES[m.first.month] + " " + m.first.year.to_s 
  end
   
  13.times do |m|
    avg = 0
    n = m + 1
    avg = avg_price_month(n.months.ago, (n - 1).months.ago)
    avg == Float::INFINITY ? avg = 0 : avg = avg
    @avg_month_prices << avg 
  end
  
  @date = Date.today
  @date.strftime("%B")
  @months <<  Date::MONTHNAMES[@date.month] + " " + @date.year.to_s

  365.times do |m|
    avg = 0
    n = m + 1
    avg = avg_price_month(n.days.ago, (n - 1).days.ago)
    avg == Float::INFINITY ? avg = 0 : avg = avg
    @avg_day_prices << avg 
  end
  
	 @prices_chart = LazyHighCharts::HighChart.new('graph') do |f|
  	 f.title(:text => "Avg Price Of Marijuana Last Year")
  	 f.xAxis(:categories => @months)
  	 f.series(:name => "Average Price Per Oz", :yAxis => 0, :data => @avg_month_prices.reverse)
  	 f.yAxis [
  	   {:title => {:text => "Average Price In USD", :margin => 70} },
  	 ]
  	 f.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical',)
  	 f.chart({:defaultSeriesType=>"column"})
	 end
	
    @chart4 = LazyHighCharts::HighChart.new('column') do |f|
      f.series(:name=>'Average Price',:data=> @avg_day_prices)
      f.title({ :text=>"example test title from controller"})
      f.options[:chart][:defaultSeriesType] = "spline"
      f.plot_options({:column=>{:stacking=>"percent"}})
    end

	end

private

	def last_year_months
		start_date = 12.months.ago.to_date
	# => Wed, 16 Nov 2011
	
		end_date = Date.today
	# => Sun, 16 Dec 2012
	
		number_of_months = (end_date.year*12+end_date.month)-(start_date.year*12+start_date.month)
	# => 13
		@last_year_in_months = number_of_months.times.each_with_object([]) do |count, array|
		  array << [start_date.beginning_of_month + count.months,
		            start_date.end_of_month + count.months]
		end
	end
	
	def avg_price_month(start, stop)
		total = 0.00
		@last_price = Price.where("created_at > ? AND created_at < ?", start, stop ) 
		@last_price.each do |n| 
			@total = @total.to_f + n.cost.to_f 
		end 
		(@total.to_f / @last_price.count.to_f)
	end

end