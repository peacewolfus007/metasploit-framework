require 'swagger/blocks'

module ServiceApiDoc
  include Swagger::Blocks

  HOST_DESC = 'The host where this service is running.'
  HOST_EXAMPLE = '127.0.0.1'
  PORT_DESC = 'The port this service is listening on.'
  PORT_EXAMPLE = '443'
  PROTO_DESC = 'The transport layer protocol this service is using.'
  PROTO_ENUM = ['tcp', 'udp']
  NAME_DESC = 'The application layer protocol.'
  NAME_EXAMPLE = "'ssh', 'mssql', 'smb', etc."
  STATE_DESC = 'The current listening state of the service.'
  STATE_ENUM = ['open', 'closed', 'filtered', 'unknown']
  INFO_DESC = 'Detailed information about the service such as name and version information.'
  INFO_EXAMPLE = "'ProFTPD 1.3.5', 'WEBrick httpd 1.3.1 Ruby 2.3.4', etc."

# Swagger documentation for Service model
  swagger_schema :Service do
    key :required, [:id, :port, :proto]
    property :id, type: :integer, format: :int32
    property :host_id, type: :integer, format: :int32
    property :port, type: :string, description: PORT_DESC, example: PORT_EXAMPLE
    property :proto, type: :string, description: PROTO_DESC, enum: PROTO_ENUM
    property :name, type: :string, description: NAME_DESC, example: NAME_EXAMPLE
    property :info, type: :string, description: INFO_DESC, example: INFO_EXAMPLE
    property :state, type: :string, description: STATE_DESC, enum: STATE_ENUM
    property :created_at, type: :string, format: :date_time
    property :updated_at, type: :string, format: :date_time
  end

  swagger_path '/api/v1/services' do
    # Swagger documentation for /api/v1/services GET
    operation :get do
      key :description, 'Return services that are stored in the database.'
      key :tags, [ 'service' ]

      parameter :workspace

      response 200 do
        key :description, 'Returns Service data'
        schema do
          key :type, :array
          items do
            key :'$ref', :Service
          end
        end
      end
    end

    # Swagger documentation for /api/v1/services POST
    operation :post do
      key :description, 'Create a Service.'
      key :tags, [ 'service' ]

      parameter do
        key :in, :body
        key :name, :body
        key :description, 'The attributes to assign to the service'
        key :required, true
        schema do
          property :workspace, type: :string, required: true
          property :host, type: :string, format: :ipv4, required: true, description: HOST_DESC, example: HOST_EXAMPLE
          property :port, type: :string, required: true, description: PORT_DESC, example: PORT_EXAMPLE
          property :proto, type: :string, required: true, description: PROTO_DESC, enum: PROTO_ENUM
          property :name, type: :string, description: NAME_DESC, example: NAME_EXAMPLE
          property :info, type: :string, description: INFO_DESC, example: INFO_EXAMPLE
          property :state, type: :string, description: STATE_DESC, enum: STATE_ENUM
        end
      end

      response 200 do
        key :description, 'Successful operation'
        schema do
          key :type, :object
          key :'$ref', :Service
        end
      end
    end

    # Swagger documentation for /api/v1/services/ DELETE
    operation :delete do
      key :description, 'Delete the specified services.'
      key :tags, [ 'service' ]

      parameter :delete_opts

      response 200 do
        key :description, 'Successful operation'
        schema do
          key :type, :array
          items do
            key :'$ref', :Service
          end
        end
      end
    end
  end

  swagger_path '/api/v1/services/{id}' do
    # Swagger documentation for api/v1/services/:id GET
    operation :get do
      key :description, 'Return services that are stored in the database.'
      key :tags, [ 'service' ]

      parameter :workspace

      parameter do
        key :name, :id
        key :in, :path
        key :description, 'ID of Service to retrieve'
        key :required, true
        key :type, :integer
        key :format, :int32
      end

      response 200 do
        key :description, 'Returns Service data'
        schema do
          key :type, :array
          items do
            key :'$ref', :Service
          end
        end
      end
    end

    # Swagger documentation for /api/v1/services/:id PUT
    operation :put do
      key :description, 'Update the attributes an existing Service.'
      key :tags, [ 'service' ]

      parameter :update_id

      parameter do
        key :in, :body
        key :name, :body
        key :description, 'The updated attributes to overwrite to the Service'
        key :required, true
        schema do
          key :'$ref', :Service
        end
      end

      response 200 do
        key :description, 'Successful operation'
        schema do
          key :type, :object
          key :'$ref', :Service
        end
      end
    end
  end
end