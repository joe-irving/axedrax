require "jekyll"
require "action_network_rest"

module Jekyll
  module ActionNetwork
    class Generator < ::Jekyll::Generator
      def event_campaign_id
        @event_campaign_id = @conf['event_campaign']
      end
      def client
        @client = ActionNetworkRest.new(api_key: ENV['OSDI_API_Token'])
      end
      def events
        @events = client.event_campaigns(event_campaign_id).events.list
      end
      def public_events
        public_fields = [
          "title",
          "browser_url",
          "description",
          "instructions",
          "featured_image_url",
          "start_date",
          "end_date",
          "location",
          "status"
        ]
        requirements = {
          # "status" => "confirmed",
          "visibility" => "public",
          "action_network:hidden" => false
        }
        @public_events = []
        events.each do |e|
          new_event = {}
          e['published'] = true
          requirements.each do |key,value|
            if e[key] != value
              Jekyll.logger.debug "Action Network:",  "'#{key}' is '#{e[key]}' for #{e['title']} (#{e['browser_url']}) so not publishing"
              e['published'] = false
            end
          end
          return unless e['published']

          slug = e['browser_url'].gsub("https://actionnetwork.org/events/","").gsub("/","")

          public_fields.each do |field|
            new_event[field] = e[field]
          end
          new_event.merge!(
            {
            "image" => e['featured_image_url'],
            "date" => e['start_date'],
            "slug" => slug,
            "layout" => "an-event"
            }
          )
          @public_events << new_event
        end
        @public_events
      end
      def events_collection
        @events_collection = Jekyll::Collection.new(site, collection_name)
      end
      def generate(site)
        @conf = site.config['action_network']
        collection_name="events"
        events_collection = Jekyll::Collection.new(site, collection_name)
        site.data['events'] = public_events
        if !public_events
          Jekyll.logger.info("Action Network:","No events found")
          return
        end
        @public_events.each do |e|
          path = File.join(site.source, "_#{collection_name}", "#{e['slug']}.md")
          doc = Jekyll::Document.new(path, collection: events_collection, site: site)
          doc.merge_data!(e)
          doc.content = e['description']

          events_collection.docs << doc
        end
        site.collections[collection_name] = events_collection
        return
      end
    end
  end
end
