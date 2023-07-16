% File : DataStoreModule.m
% Description : Class Definition for the Data Store

classdef DataStoreModule < handle
    
    % === Public Methods ===

    methods (Access = public)

        % constructor
        function obj = DataStoreModule()
            obj.m_data_store = struct();
        end

        % declare : Declares a new variable in the data store
        function declare(obj, key)

            % Enforce Uniqueness
            obj.p_enforceUniqueField(key);
            
            % Add blank field to data store
            obj.m_data_store.(key) = [];

        end

        % set : Sets a value to an existing variable in the data store
        function set(obj, key, value)

            % Enforce Field Existence
            obj.p_enforceExistField(key);
            
            % Set the update to the field
            obj.m_data_store.(key) = value;

        end


        % appendArray : Appends to an existing array in the datastore
        % Note : method assumes target data is an array => DOES NOT CHECK
        function appendArray(obj, key, value)

            % Check that the field exists
            obj.p_enforceExistField(key);
            
            % Append to the array
            obj.m_data_store.(key)(end + 1) = value;
        end

        % read : Reads data from the module
        function ret_data = read(obj, key)
            
            % Check that the field exists
            obj.p_enforceExistField(key);
            
            % Read data from the field
            ret_data = obj.m_data_store.(key);

        end

        % batchWrite : Unpacks and writes a structure to the data store
        function batchWrite(obj, data)

            % Check that data is a struct
            if ~isstruct(data)
                error("batchWrite() expects a struct.");
            end

            % Iterate over the struct and write to Data Store
            keys = fieldnames(data);

            for k = 1:numel(keys)
                
                key = keys{k};

                % Declare Field
                obj.declare(key);

                % Write into field
                obj.set(key, data.(key));

            end

        end

        % batchRead : Reads a set of keys and returns a struct with data
        function data_out = batchRead(obj, keys)

            % Check that keys is a vector
            if ~isvector(keys)
                error("batchRead() expects a vector.");
            end

            % Iterate over the keys and read data
            data_out = struct();

            for k = 1:numel(keys)
                
                key = keys(k);
                data_out.(key) = obj.read(key);

            end

        end

        % remove : Removes data from the module
        function remove(obj, key)

            % Check that the field exists
            obj.p_enforceExistField(key);
            
            % Remove the field from the data store
            obj.m_data_store = rmfield(obj.m_data_store, key);

        end

    end

    % === Private Methods ===

    methods (Access = private)

        % p_checkExistField : Returns true if a field exists, else false
        function exist = p_checkExistField(obj, key)
            exist = isfield(obj.m_data_store, key);
        end

        % p_enforceExistField : Throws an error if a field does not exist
        function p_enforceExistField(obj, key)
            
            if ~obj.p_checkExistField(key)
                error('The field " %s " does not exist in the data store.')
            end

        end

        % p_enforceUniqueField : Throws an error if a field already exists
        function p_enforceUniqueField(obj, key)
            
            if obj.p_checkExistField(key)
                error('The field " %s " already exists in the data store.')
            end

        end

    end

    % === Private Properties ===
    
    properties (Access = private)
        
        m_data_store; % Structure to store data

    end


end