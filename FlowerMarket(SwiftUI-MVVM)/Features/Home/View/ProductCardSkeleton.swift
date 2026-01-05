

import SwiftUI
struct ProductCardSkeleton: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // مكان الصورة
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.gray.opacity(0.1))
                .frame(width: 160, height: 160)
                .shimmer()
            
            // مكان العنوان
            RoundedRectangle(cornerRadius: 4)
                .fill(Color.gray.opacity(0.1))
                .frame(width: 120, height: 15)
                .shimmer()
            
            // مكان السعر
            RoundedRectangle(cornerRadius: 4)
                .fill(Color.gray.opacity(0.1))
                .frame(width: 60, height: 15)
                .shimmer()
        }
        .padding(10)
        .background(Color.white)
        .cornerRadius(24)
    }
}
