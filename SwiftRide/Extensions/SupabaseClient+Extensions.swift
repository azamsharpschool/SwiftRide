//
//  SupabaseClient+Extensions.swift
//  SwiftRide
//
//  Created by Mohammad Azam on 3/3/25.
//

import Foundation
import Supabase

extension SupabaseClient {
    
    static var development: SupabaseClient {
        SupabaseClient(supabaseURL: URL(string: "https://xjhidioitjxkstusjldr.supabase.co")!, supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhqaGlkaW9pdGp4a3N0dXNqbGRyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzk4Mzg3MTksImV4cCI6MjA1NTQxNDcxOX0.1vyOMEioRKVGIET4ee20pXoDZkkSOF8AnnZV8Uss71g")
    }
    
}
