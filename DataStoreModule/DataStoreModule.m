% File : DataStoreModule.m
% Description : Defines the data store module class
% Usage : This class should be instantiated ONCE in the control module and
% passed down by reference to any module that requires access

classdef DataStoreModule < handle
        
    % === Public Methods ===
    methods (Access = public)
        
        % constructor
        function obj = DataStoreModule()
            obj.m_data_store = struct();
        end

        % write : Writes data into the module
        function write(obj, key, value)
            obj.m_data_store = setfield(obj.m_data_store, key, value);
        end

        % appendArray : Appends to an existing array in the datastore
        % Note : This assumes the data you append to IS AN ARRAY, it does
        % not check!
        function appendArray(obj, key, value)

            if ~(isfield(obj.m_data_store, key))
                error('" %s " is either not a valid key or it does not point to an array', key);
            end

            obj.m_data_store.(key)(end + 1) = value;
        end

        % read : Reads data from the module
        function ret_data = read(obj, key)
            
            if ~isfield(obj.m_data_store, key)
                error('The key " %s " does not exist in the datastore', key);
            end

            ret_data = obj.m_data_store.(key);

        end

        % remove : Removes data from the module
        function remove(obj, key)

            if ~ isfield(obj.m_data_store, key)
                error('The key " %s " does not exist in the datastore', key);
            end

            obj.m_data_store = rmfield(obj.m_data_store, key);

        end

        % getKeys : Returns all keys in the data store
        function keys = getKeys(obj)
            keys = fieldnames(obj.m_data_store);
        end

    end

    % === Private Properties ===
    properties (Access = private)
        m_data_store;
    end
end


