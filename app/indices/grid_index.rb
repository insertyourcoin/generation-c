ThinkingSphinx::Index.define :grid, with: :active_record do
  indexes name
  indexes description
  has user_id, created_at, updated_at
end