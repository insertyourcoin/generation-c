ThinkingSphinx::Index.define :rule, with: :active_record do
  indexes name
  indexes description
  has user_id, created_at, updated_at, turn_on, turn_off
end